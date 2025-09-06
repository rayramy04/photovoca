
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/camera_controller_provider.dart';
import 'detection_overlay.dart';

class CameraSheet extends ConsumerWidget {
  const CameraSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerAsync = ref.watch(cameraControllerProvider);
    final h = MediaQuery.of(context).size.height;
    return CupertinoPopupSurface(
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: h * 0.85,
          child: Stack(
            children: [
              Positioned.fill(
                child: switch (controllerAsync) {
                  AsyncData<CameraController?>(:final value) => value == null
                      ? const Center(
                          child: Text('No camera available'),
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            CameraPreview(value),
                            // オブジェクト選択時はプレビューは上位で出すため、ここでは即dismiss
                            DetectionOverlay(onCropped: (bytes) {
                              Navigator.of(context).pop(bytes);
                            }),
                          ],
                        ),
                  AsyncError(:final error) => Center(
                      child: Text('Camera error: $error'),
                    ),
                  _ => const Center(child: CupertinoActivityIndicator()),
                },
              ),
              Positioned(
                right: 12,
                top: 12,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.xmark_circle_fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
