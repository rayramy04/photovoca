
import 'dart:typed_data' show Uint8List;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, CustomPainter, PaintingStyle, Paint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/object_detection_provider.dart';
import '../application/object_recognition_provider.dart';
import 'cropped_preview_sheet.dart';

class DetectionOverlay extends ConsumerWidget {
  const DetectionOverlay({super.key, this.onCropped});

  final ValueChanged<Uint8List>? onCropped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boxes = ref.watch(objectDetectionProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) async {
            if (boxes.isEmpty) return;
            final normTap = _positionToNormalized(size, details.localPosition);

            for (final b in boxes) {
              if (b.rectNorm.contains(Offset(normTap.dx, normTap.dy))) {
                if (kDebugMode) {
                  debugPrint('[OVERLAY] tap hit id=${b.id}');
                }
                final cropped = await ref
                    .read(objectRecognitionProvider.notifier)
                    .captureAndCrop(b.rectNorm);
                if (!context.mounted) return;
                if (onCropped != null) {
                  onCropped!(cropped);
                } else {
                  await showCupertinoModalPopup(
                    context: context,
                    builder: (ctx) => CroppedPreviewSheet(croppedBytes: cropped),
                  );
                }
                break;
              }
            }
          },
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _BoxesPainter(boxes),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }

  Offset _positionToNormalized(Size widgetSize, Offset pos) {
    return Offset(
      (pos.dx / widgetSize.width).clamp(0.0, 1.0),
      (pos.dy / widgetSize.height).clamp(0.0, 1.0),
    );
  }
}

class _BoxesPainter extends CustomPainter {
  _BoxesPainter(this.boxes);
  final List<TrackedBox> boxes;

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fill = Paint()
      ..color = Colors.lightGreenAccent.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    for (final b in boxes) {
      final r = Rect.fromLTRB(
        b.rectNorm.left * size.width,
        b.rectNorm.top * size.height,
        b.rectNorm.right * size.width,
        b.rectNorm.bottom * size.height,
      );
      canvas.drawRect(r, fill);
      canvas.drawRect(r, border);
    }
  }

  @override
  bool shouldRepaint(covariant _BoxesPainter oldDelegate) {
    return !listEquals(oldDelegate.boxes, boxes);
  }
}
