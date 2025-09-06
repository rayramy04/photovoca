import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/flash_card.dart';
import '../domain/quiz_session.dart';
import 'package:material_study_coach/infrastructure/providers/database_providers.dart';

final quizModeProvider = StateProvider<QuizMode>((ref) {
  return QuizMode.japaneseToEnglish;
});

final quizSessionProvider = NotifierProvider<QuizSessionNotifier, QuizSession>(
  QuizSessionNotifier.new,
);

class QuizSessionNotifier extends Notifier<QuizSession> {
  @override
  QuizSession build() {
    final vocabAsync = ref.watch(quizVocabulariesProvider);
    final mode = ref.watch(quizModeProvider);

    final cards = (vocabAsync.asData?.value ?? []).map((v) => FlashCard(
          id: v.id.toString(),
          japanese: v.japanese,
          reading: v.reading,
          english: v.english,
          isMastered: v.isMastered,
          reviewCount: v.masteredCount,
          lastReviewedAt: v.lastReviewedAt,
        ))
        .toList()
      ..shuffle();

    final initialMasteredIds = cards.where((c) => c.isMastered).map((c) => c.id).toList();

    return QuizSession(
      cards: cards,
      mode: mode,
      masteredCardIds: initialMasteredIds,
      startedAt: DateTime.now(),
    );
  }

  void nextCard() {
    final session = state;
    if (session.currentIndex < session.cards.length - 1) {
      state = session.copyWith(currentIndex: session.currentIndex + 1);
    }
  }

  void previousCard() {
    final session = state;
    if (session.currentIndex > 0) {
      state = session.copyWith(currentIndex: session.currentIndex - 1);
    }
  }

  void markAsMastered(String cardId) {
    final session = state;
    final masteredIds = [...session.masteredCardIds];
    final reviewLaterIds = [...session.reviewLaterCardIds];
    
    if (!masteredIds.contains(cardId)) {
      masteredIds.add(cardId);
      reviewLaterIds.remove(cardId);
    }
    
    state = session.copyWith(
      masteredCardIds: masteredIds,
      reviewLaterCardIds: reviewLaterIds,
    );
  }

  void markForReview(String cardId) {
    final session = state;
    final masteredIds = [...session.masteredCardIds];
    final reviewLaterIds = [...session.reviewLaterCardIds];
    
    if (!reviewLaterIds.contains(cardId)) {
      reviewLaterIds.add(cardId);
      masteredIds.remove(cardId);
    }
    
    state = session.copyWith(
      masteredCardIds: masteredIds,
      reviewLaterCardIds: reviewLaterIds,
    );
  }

  void resetSession() {
    ref.invalidateSelf();
  }

  void changeMode(QuizMode mode) {
    ref.read(quizModeProvider.notifier).state = mode;
    resetSession();
  }

  void goToCard(int index) {
    if (index >= 0 && index < state.cards.length) {
      state = state.copyWith(currentIndex: index);
    }
  }
}

final currentCardProvider = Provider<FlashCard?>((ref) {
  final session = ref.watch(quizSessionProvider);
  if (session.cards.isEmpty) return null;
  if (session.currentIndex >= session.cards.length) return null;
  return session.cards[session.currentIndex];
});

final masteredPercentageProvider = Provider<double>((ref) {
  final session = ref.watch(quizSessionProvider);
  if (session.cards.isEmpty) return 0.0;
  return session.masteredCardIds.length / session.cards.length;
});

final masteredCountProvider = Provider<int>((ref) {
  final session = ref.watch(quizSessionProvider);
  return session.masteredCardIds.length;
});

// 左→右に単調増加する一般的な進捗バーのためのプロバイダー
final maxIndexReachedProvider = StateProvider<int>((ref) => 0);

final quizLinearProgressProvider = Provider<double>((ref) {
  final session = ref.watch(quizSessionProvider);
  final maxIndex = ref.watch(maxIndexReachedProvider);
  final total = session.cards.length;
  if (total == 0) return 0.0;
  if (total == 1) return 1.0;
  final ratio = maxIndex / (total - 1);
  return ratio.clamp(0.0, 1.0);
});
