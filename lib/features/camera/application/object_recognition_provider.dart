import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../domain/detected_object.dart';
import '../infrastructure/camera_controller_provider.dart';
import '../infrastructure/gemini_object_recognizer.dart';
import 'object_detection_provider.dart';

final objectRecognitionProvider = AutoDisposeAsyncNotifierProvider<
    ObjectRecognitionNotifier, DetectedObject?>(ObjectRecognitionNotifier.new);

class ObjectRecognitionNotifier extends AutoDisposeAsyncNotifier<DetectedObject?> {
  @override
  FutureOr<DetectedObject?> build() async {
    return null;
  }

  Future<void> analyzeCurrentView() async {
    if (kDebugMode) {
      debugPrint('[RECOG] analyzeCurrentView triggered');
    }
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null || !controller.value.isInitialized) {
      state = const AsyncValue.error('Camera not initialized', StackTrace.empty);
      if (kDebugMode) {
        debugPrint('[RECOG] camera not initialized');
      }
      return;
    }

    state = const AsyncLoading();
    try {
      if (kDebugMode) {
        debugPrint('[RECOG] taking picture');
      }
      final XFile file = await controller.takePicture();
      final bytes = await file.readAsBytes();
      if (kDebugMode) {
        debugPrint('[RECOG] picture bytes=${bytes.length}');
      }
      final recognizer = ref.read(geminiRecognizerProvider);
      final result = await recognizer.detectObjectNameFromImage(bytes);
      state = AsyncValue.data(result);
      if (kDebugMode) {
        debugPrint('[RECOG] success: ${result.nameEn}');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      if (kDebugMode) {
        debugPrint('[RECOG] error: $e');
      }
    }
  }

  Future<void> analyzeBytes(List<int> bytes) async {
    state = const AsyncLoading();
    try {
      final recognizer = ref.read(geminiRecognizerProvider);
      final result = await recognizer.detectObjectNameFromImage(Uint8List.fromList(bytes));
      state = AsyncValue.data(result);
      if (kDebugMode) {
        debugPrint('[RECOG] success(bytes): ${result.nameEn}');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      if (kDebugMode) {
        debugPrint('[RECOG] error(bytes): $e');
      }
    }
  }

  Future<void> analyzeCurrentViewWithCrop(Rect normalizedRect) async {
    if (kDebugMode) {
      debugPrint('[RECOG] analyzeCurrentViewWithCrop triggered rect=$normalizedRect');
    }
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null || !controller.value.isInitialized) {
      state = const AsyncValue.error('Camera not initialized', StackTrace.empty);
      if (kDebugMode) {
        debugPrint('[RECOG] camera not initialized');
      }
      return;
    }

    state = const AsyncLoading();
    try {
      final wasStreaming = controller.value.isStreamingImages;
      if (wasStreaming) {
        try {
          await controller.stopImageStream();
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[CAMERA] stopImageStream ignored (analyzeCurrentViewWithCrop): $e');
          }
        }
      }
      final XFile file = await controller.takePicture();
      final bytes = await file.readAsBytes();

      final decoded = img.decodeImage(bytes);
      if (decoded == null) {
        throw StateError('Failed to decode image');
      }
      final imgW = decoded.width;
      final imgH = decoded.height;
      int left = (normalizedRect.left * imgW).clamp(0, imgW - 1).toInt();
      int top = (normalizedRect.top * imgH).clamp(0, imgH - 1).toInt();
      int right = (normalizedRect.right * imgW).clamp(0, imgW).toInt();
      int bottom = (normalizedRect.bottom * imgH).clamp(0, imgH).toInt();
      int cropW = (right - left).clamp(1, imgW - left);
      int cropH = (bottom - top).clamp(1, imgH - top);
      final cropped = img.copyCrop(decoded, x: left, y: top, width: cropW, height: cropH);
      final croppedBytes = Uint8List.fromList(img.encodeJpg(cropped, quality: 90));

      final recognizer = ref.read(geminiRecognizerProvider);
      final result = await recognizer.detectObjectNameFromImage(croppedBytes);
      final withBox = result.copyWith(
        boundingBox: RectJson(
          left: normalizedRect.left,
          top: normalizedRect.top,
          right: normalizedRect.right,
          bottom: normalizedRect.bottom,
        ),
      );
      state = AsyncValue.data(withBox);
      if (kDebugMode) {
        debugPrint('[RECOG] success(crop): ${withBox.nameEn}');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      if (kDebugMode) {
        debugPrint('[RECOG] error(crop): $e');
      }
    } finally {
      // Ask detection provider to restart its stream
      ref.invalidate(objectDetectionProvider);
    }
  }

  // 撮影→指定領域をクロップして返す（モーダル用）
  Future<Uint8List> captureAndCrop(Rect normalizedRect) async {
    final controller = await ref.read(cameraControllerProvider.future);
    if (controller == null || !controller.value.isInitialized) {
      throw StateError('Camera not initialized');
    }
    // 競合回避のため一時的にストリーム停止
    final wasStreaming = controller.value.isStreamingImages;
    if (wasStreaming) {
      try {
        await controller.stopImageStream();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[CAMERA] stopImageStream ignored (captureAndCrop): $e');
        }
      }
    }
    try {
      final XFile file = await controller.takePicture();
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) {
        throw StateError('Failed to decode image');
      }
      final imgW = decoded.width;
      final imgH = decoded.height;
      final left = (normalizedRect.left * imgW).clamp(0, imgW - 1).toInt();
      final top = (normalizedRect.top * imgH).clamp(0, imgH - 1).toInt();
      final right = (normalizedRect.right * imgW).clamp(0, imgW).toInt();
      final bottom = (normalizedRect.bottom * imgH).clamp(0, imgH).toInt();
      final cropW = (right - left).clamp(1, imgW - left);
      final cropH = (bottom - top).clamp(1, imgH - top);
      final cropped = img.copyCrop(decoded, x: left, y: top, width: cropW, height: cropH);
      return Uint8List.fromList(img.encodeJpg(cropped, quality: 92));
    } finally {
      // リスナーを貼り直して検出再開
      ref.invalidate(objectDetectionProvider);
    }
  }
}
