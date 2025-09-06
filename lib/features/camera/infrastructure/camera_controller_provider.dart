import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availableCamerasProvider = FutureProvider<List<CameraDescription>>((ref) {
  return availableCameras().then((cams) {
    if (kDebugMode) {
      debugPrint('[CAMERA] available: ${cams.length}');
      for (final c in cams) {
        debugPrint('[CAMERA] ${c.name} (${c.lensDirection.name})');
      }
    }
    return cams;
  });
});

final cameraControllerProvider =
    AutoDisposeAsyncNotifierProvider<CameraControllerNotifier, CameraController?>(
        CameraControllerNotifier.new);

class CameraControllerNotifier
    extends AutoDisposeAsyncNotifier<CameraController?> {
  @override
  FutureOr<CameraController?> build() async {
    final cameras = await ref.watch(availableCamerasProvider.future);
    if (cameras.isEmpty) return null;
    final controller = CameraController(
      cameras.first,
      ResolutionPreset.max,
      enableAudio: false,
    );
    if (kDebugMode) {
      debugPrint('[CAMERA] initializing controller with ${cameras.first.name}');
    }
    await controller.initialize();
    if (kDebugMode) {
      debugPrint('[CAMERA] initialized: ${controller.description.name}');
    }
    ref.onDispose(() async {
      if (kDebugMode) {
        debugPrint('[CAMERA] disposing controller');
      }
      await controller.dispose();
    });
    return controller;
  }
}
