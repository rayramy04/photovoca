import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import '../infrastructure/camera_controller_provider.dart';

class TrackedBox {
  const TrackedBox({
    required this.id,
    required this.rectNorm, // 標準化
  });

  final int id;
  final Rect rectNorm;
}

final objectDetectionProvider =
    AutoDisposeNotifierProvider<ObjectDetectionNotifier, List<TrackedBox>>(
        ObjectDetectionNotifier.new);

class ObjectDetectionNotifier extends AutoDisposeNotifier<List<TrackedBox>> {
  ObjectDetector? _detector;
  bool _processing = false;
  int _frameCount = 0;

  @override
  List<TrackedBox> build() {
    state = const [];
    _detector ??= ObjectDetector(
      options: ObjectDetectorOptions(
        classifyObjects: false,
        multipleObjects: true,
        mode: DetectionMode.stream,
      ),
    );
    _start();
    ref.onDispose(() async {
      await _stop();
      if (_detector != null) {
        await _detector!.close();
        _detector = null;
      }
    });
    return state;
  }

  Future<void> _start() async {
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isStreamingImages) return;
    await controller.startImageStream(_onImage);
  }

  Future<void> _stop() async {
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null) return;
    // コントローラがdispose済み/未初期化なら何もしない
    final isInitialized = controller.value.isInitialized;
    if (!isInitialized) return;
    if (controller.value.isStreamingImages) {
      try {
        await controller.stopImageStream();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[CAMERA] stopImageStream ignored: $e');
        }
      }
    }
  }

  Future<void> _onImage(CameraImage image) async {
    _frameCount++;
    if (_processing || (_frameCount % 3 != 0)) return;
    _processing = true;
    try {
      final inputImage = _toInputImage(image, await _rotation());
      final detector = _detector;
      if (detector == null) return;
      final objects = await detector.processImage(inputImage);
      final size = inputImage.metadata?.size;
      if (size == null) {
        _processing = false;
        return;
      }
      final w = size.width.toDouble();
      final h = size.height.toDouble();
      final results = <TrackedBox>[];
      for (final o in objects) {
        final r = o.boundingBox;
        final left = (r.left / w).clamp(0.0, 1.0);
        final top = (r.top / h).clamp(0.0, 1.0);
        final right = (r.right / w).clamp(0.0, 1.0);
        final bottom = (r.bottom / h).clamp(0.0, 1.0);
        results.add(TrackedBox(
          id: o.trackingId ?? o.hashCode,
          rectNorm: Rect.fromLTRB(left, top, right, bottom),
        ));
      }
      state = results;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[MLKIT] error: $e');
      }
    } finally {
      _processing = false;
    }
  }

  Future<InputImageRotation> _rotation() async {
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null) return InputImageRotation.rotation0deg;
    final degrees = controller.description.sensorOrientation;
    return InputImageRotationValue.fromRawValue(degrees) ??
        InputImageRotation.rotation0deg;
  }

  static InputImage _toInputImage(
      CameraImage image, InputImageRotation rotation) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.yuv420;
    final metadata = InputImageMetadata(
      size: imageSize,
      rotation: rotation,
      format: inputImageFormat,
      bytesPerRow: image.planes.isNotEmpty ? image.planes.first.bytesPerRow : 0,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }
}
