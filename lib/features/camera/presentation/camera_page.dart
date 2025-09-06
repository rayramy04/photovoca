import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:go_router/go_router.dart';

import '../../camera/application/object_recognition_provider.dart';
import '../../camera/application/object_history_provider.dart';
import '../../camera/infrastructure/camera_controller_provider.dart';
import 'detection_overlay.dart';
// removed mock vocabulary samples from camera UI

/* 
  Widgetクラスで共有部分は切り出してもいいんだけど、今回は小規模（コア処理に重きを置いている）なので
  共通化はしません。
*/

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {

  // sheet removed

  @override
  Widget build(BuildContext context) {
    final controllerAsync = ref.watch(cameraControllerProvider);
    final recognition = ref.watch(objectRecognitionProvider);
    // removed mock vocabulary usage

    // 認識が完了したら履歴に追加
    ref.listen(objectRecognitionProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        ref.read(objectHistoryProvider.notifier).addObject(next.value!);
      }
    });

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // フルスクリーンカメラビュー
          Positioned.fill(
            child: switch (controllerAsync) {
              AsyncData<CameraController?>(:final value) =>
                value == null
                    ? const Center(
                        child: Text(
                          'No camera available',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      )
                    : CameraPreview(value),
              AsyncError(:final error) => Center(
                child: Text(
                  'Camera error: $error',
                  style: const TextStyle(color: CupertinoColors.white),
                ),
              ),
              _ => const Center(
                child: CupertinoActivityIndicator(color: CupertinoColors.white),
              ),
            },
          ),

          const Positioned.fill(child: DetectionOverlay()),

          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                if ((dotenv.env['API_KEY'] ?? '').isEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemRed.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Missing API_KEY in .env file. Please add your Gemini API key.',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (recognition.isLoading)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoActivityIndicator(
                          color: CupertinoColors.white,
                          radius: 8,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Analyzing...',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                // 右上の画像ピッカーボタンは削除
              ],
            ),
          ),

          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: controllerAsync is AsyncData
                    ? () => ref
                          .read(objectRecognitionProvider.notifier)
                          .analyzeCurrentView()
                    : null,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.white,
                    border: Border.all(
                      color: CupertinoColors.systemGrey5,
                      width: 6,
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.camera,
                    size: 30,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            ),
          ),

          /* AnimatedBuilder(
            animation: _sheetAnimation,
            builder: (context, child) {
              final screenHeight = MediaQuery.of(context).size.height;
              // iOS Sheetのステージング設定。現状3段階で考えてるが、2段階にして単語のページは
              // 別ページに切り出してもいいかも。
              final stage1Height = screenHeight * 0.25; // ステージ0：画面の25%
              final stage2Height = screenHeight * 0.5; // ステージ1：画面の50%
              final stage3Height = screenHeight * 0.9; // ステージ2：画面の90%

              double currentHeight;
              final animationValue = _sheetAnimation.value;

              if (animationValue <= 0.5) {
                // 25% to 50%
                currentHeight =
                    stage1Height +
                    ((stage2Height - stage1Height) * animationValue * 2);
              } else {
                // 50% to 90%
                currentHeight =
                    stage2Height +
                    ((stage3Height - stage2Height) *
                        (animationValue - 0.5) *
                        2);
              }

              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final delta = -details.delta.dy / screenHeight;
                    final newValue = (_sheetController.value + delta).clamp(
                      0.0,
                      1.0,
                    );
                    _sheetController.value = newValue;
                  },
                  onPanEnd: (details) {
                    final velocity =
                        -details.velocity.pixelsPerSecond.dy / screenHeight;
                    if (velocity.abs() > 0.5) {
                      // 速いスワイプ
                      if (velocity > 0) {
                        // 上向き
                        if (_currentStage < 2)
                          _animateToStage(_currentStage + 1);
                      } else {
                        // 下向き
                        if (_currentStage > 0)
                          _animateToStage(_currentStage - 1);
                      }
                    } else {
                      // 遅い場合は最も近いページにjump
                      final closestStage = _getClosestStage(
                        _sheetController.value,
                      );
                      _animateToStage(closestStage);
                    }
                  },
                  child: Container(
                    height: currentHeight,
                    decoration: const BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final nextStage = (_currentStage + 1) % 3;
                            _animateToStage(nextStage);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey3,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Vocabulary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              CupertinoButton(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                onPressed: () {
                                  context.pushNamed('quiz');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.activeBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.play_fill,
                                        size: 16,
                                        color: CupertinoColors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'クイズ',
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: vocabulary.length,
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: CupertinoColors.separator,
                            ),
                            itemBuilder: (context, index) {
                              final word = vocabulary[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    // 日本語と読み
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            word.japanese,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            word.reading,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // 矢印
                                    const Icon(
                                      CupertinoIcons.arrow_right,
                                      color: CupertinoColors.systemGrey2,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            word.english,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (word.category.isNotEmpty)
                                            Text(
                                              word.category,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    CupertinoColors.systemGrey,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
                ),
              );
            },
          ), */
        ],
      ),
    );
  }
}

// removed helper preview holder
