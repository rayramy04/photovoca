import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/quiz_session_provider.dart';
import '../domain/flash_card.dart';
import '../domain/quiz_session.dart';
import 'package:material_study_coach/infrastructure/providers/database_providers.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> 
    with TickerProviderStateMixin {
  late PageController pageController;
  late AnimationController flipController;
  late Animation<double> flipAnimation;
  bool isFlipped = false;
  bool _completionShown = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: flipController, curve: Curves.easeInOut),
    );
    // 一般的な進捗（左→右）を0から開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(maxIndexReachedProvider.notifier).state = 0;
      _maybeShowCompletion();
    });
  }

  Future<void> _maybeShowCompletion() async {
    if (!mounted) return;
    final session = ref.read(quizSessionProvider);
    if (session.cards.isEmpty) return;
    final isLast = session.currentIndex == session.cards.length - 1;
    if (isLast && !_completionShown) {
      _completionShown = true;
      final ok = await showCupertinoDialog<bool>(
        context: context,
        builder: (ctx) => const _QuizCompletedDialog(),
      );
      if (ok == true && mounted) {
        context.pop();
      }
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(quizSessionProvider);
    final currentCard = ref.watch(currentCardProvider);
    final progress = ref.watch(quizLinearProgressProvider);
    ref.watch(masteredPercentageProvider);
    final masteredCount = ref.watch(masteredCountProvider);

    void handleFlip() {
      if (flipController.isAnimating) return;
      
      if (isFlipped) {
        flipController.reverse();
      } else {
        flipController.forward();
      }
      setState(() {
        isFlipped = !isFlipped;
      });
    }

    void handleNextCard() {
      setState(() {
        isFlipped = false;
      });
      flipController.reset();
      final targetIndex = ref.read(quizSessionProvider).currentIndex + 1;
      ref.read(quizSessionProvider.notifier).nextCard();
      final currentMax = ref.read(maxIndexReachedProvider);
      if (targetIndex > currentMax) {
        ref.read(maxIndexReachedProvider.notifier).state = targetIndex;
      }
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void handlePreviousCard() {
      setState(() {
        isFlipped = false;
      });
      flipController.reset();
      ref.read(quizSessionProvider.notifier).previousCard();
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF0F072C),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF0F072C),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            final shouldExit = await showCupertinoDialog<bool>(
              context: context,
              builder: (ctx) => const _ExitQuizDialog(),
            );
            if (shouldExit == true && mounted) {
              context.pop();
            }
          },
          child: const Text('終了', style: TextStyle(color: CupertinoColors.white)),
        ),
        middle: const Text(
          'Quiz',
          style: TextStyle(color: CupertinoColors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => _QuizModeSelector(
                currentMode: session.mode,
                onModeChanged: (mode) {
                  ref.read(quizSessionProvider.notifier).changeMode(mode);
                  Navigator.pop(context);
                },
              ),
            );
          },
          child: const Icon(CupertinoIcons.slider_horizontal_3, color: CupertinoColors.white),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1044),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress ${(progress * 100).toInt()}%',
                          style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                        ),
                        Text(
                          'Mastered $masteredCount/${session.cards.length}',
                          style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFF2A1A62),
                      valueColor: const AlwaysStoppedAnimation<Color>(CupertinoColors.activeBlue),
                      minHeight: 8,
                    ),
                  ],
                ),
              ),
            ),
            
            Expanded(
              child: currentCard == null
                  ? const Center(
                      child: Text(
                        'No cards available',
                        style: TextStyle(color: CupertinoColors.systemGrey),
                      ),
                    )
                  : PageView.builder(
                      controller: pageController,
                      itemCount: session.cards.length,
                      onPageChanged: (index) {
                        setState(() {
                          isFlipped = false;
                        });
                        flipController.reset();
                        ref.read(quizSessionProvider.notifier).goToCard(index);
                        final currentMax = ref.read(maxIndexReachedProvider);
                        if (index > currentMax) {
                          ref.read(maxIndexReachedProvider.notifier).state = index;
                        }
                        // 最後のページに到達したら完了ダイアログ
                        _maybeShowCompletion();
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: handleFlip,
                            child: AnimatedBuilder(
                              animation: flipAnimation,
                              builder: (context, child) {
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(math.pi * flipAnimation.value),
                                  child: flipAnimation.value <= 0.5
                                  ? _CardFront(
                                      card: session.cards[index],
                                      mode: session.mode,
                                    )
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..rotateY(math.pi),
                                      child: _CardBack(
                                        card: session.cards[index],
                                        mode: session.mode,
                                      ),
                                    ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            
            if (currentCard != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _IconPillButton(
                          onPressed: session.currentIndex > 0 ? handlePreviousCard : null,
                          icon: CupertinoIcons.arrow_left,
                        ),
                        
                        CupertinoButton.filled(
                          onPressed: () async {
                            final cardId = currentCard.id;
                            final dbId = int.tryParse(cardId);
                            if (session.masteredCardIds.contains(cardId)) {
                              // セッション内のフラグのみ戻す（DBは進捗を下げない）
                              ref.read(quizSessionProvider.notifier)
                                  .markForReview(cardId);
                            } else {
                              ref.read(quizSessionProvider.notifier)
                                  .markAsMastered(cardId);
                              // DBの進捗を更新（回数+1、閾値到達でMastered）
                              if (dbId != null) {
                                await ref
                                    .read(vocabularyProgressNotifierProvider.notifier)
                                    .incrementMasteredCount(dbId);
                              }
                            }
                          },
                          child: Icon(
                            session.masteredCardIds.contains(currentCard.id)
                                ? CupertinoIcons.star_fill
                                : CupertinoIcons.star,
                            color: CupertinoColors.white,
                          ),
                        ),
                        
                        _IconPillButton(
                          onPressed: session.currentIndex < session.cards.length - 1 ? handleNextCard : null,
                          icon: CupertinoIcons.arrow_right,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    Text(
                      'Tap card to flip',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({
    required this.card,
    required this.mode,
  });

  final FlashCard card;
  final QuizMode mode;

  @override
  Widget build(BuildContext context) {
    final displayText = mode == QuizMode.japaneseToEnglish ? card.japanese : card.english;
    final subText = mode == QuizMode.japaneseToEnglish ? card.reading : '';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1044),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w700,
                color: CupertinoColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (subText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                subText,
                style: const TextStyle(fontSize: 20, color: CupertinoColors.systemGrey),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({
    required this.card,
    required this.mode,
  });

  final FlashCard card;
  final QuizMode mode;

  @override
  Widget build(BuildContext context) {
    final displayText = mode == QuizMode.japaneseToEnglish ? card.english : card.japanese;
    final subText = mode == QuizMode.japaneseToEnglish ? '' : card.reading;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C7DFF), Color(0xFF2A6BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (subText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                subText,
                style: TextStyle(fontSize: 20, color: CupertinoColors.white.withValues(alpha: 0.9)),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuizModeSelector extends StatelessWidget {
  const _QuizModeSelector({
    required this.currentMode,
    required this.onModeChanged,
  });

  final QuizMode currentMode;
  final ValueChanged<QuizMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Quiz Mode'),
      message: const Text('Select which language to show first'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => onModeChanged(QuizMode.japaneseToEnglish),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentMode == QuizMode.japaneseToEnglish)
                const Icon(CupertinoIcons.checkmark_alt, size: 20),
              const SizedBox(width: 8),
              const Text('Japanese → English'),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () => onModeChanged(QuizMode.englishToJapanese),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentMode == QuizMode.englishToJapanese)
                const Icon(CupertinoIcons.checkmark_alt, size: 20),
              const SizedBox(width: 8),
              const Text('English → Japanese'),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        isDefaultAction: true,
        child: const Text('Cancel'),
      ),
    );
  }
}

class LinearProgressIndicator extends StatelessWidget {
  const LinearProgressIndicator({
    super.key,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    required this.minHeight,
  });

  final double value;
  final Color backgroundColor;
  final AlwaysStoppedAnimation<Color> valueColor;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: minHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(minHeight / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: BoxDecoration(
            color: valueColor.value,
            borderRadius: BorderRadius.circular(minHeight / 2),
          ),
        ),
      ),
    );
  }
}

class _ExitQuizDialog extends StatelessWidget {
  const _ExitQuizDialog();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('クイズを終了しますか？'),
      content: const Text('ホームに戻ります。'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          isDefaultAction: true,
          child: const Text('キャンセル'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          isDestructiveAction: true,
          child: const Text('終了'),
        ),
      ],
    );
  }
}

class _QuizCompletedDialog extends StatelessWidget {
  const _QuizCompletedDialog();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('クイズ完了'),
      content: const Text('すべてのカードを学習しました。ホームに戻りますか？'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          isDefaultAction: true,
          child: const Text('とどまる'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          isDestructiveAction: true,
          child: const Text('戻る'),
        ),
      ],
    );
  }
}

class _IconPillButton extends StatelessWidget {
  const _IconPillButton({required this.onPressed, required this.icon});
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1044),
        borderRadius: BorderRadius.circular(28),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(28),
        color: const Color(0x00000000),
        onPressed: onPressed,
        child: Icon(icon, color: CupertinoColors.white),
      ),
    );
  }
}
