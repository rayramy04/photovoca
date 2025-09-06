import 'package:freezed_annotation/freezed_annotation.dart';
import 'flash_card.dart';

part 'quiz_session.freezed.dart';
part 'quiz_session.g.dart';

enum QuizMode {
  japaneseToEnglish,
  englishToJapanese,
}

@freezed
class QuizSession with _$QuizSession {
  const factory QuizSession({
    required List<FlashCard> cards,
    required QuizMode mode,
    @Default(0) int currentIndex,
    @Default([]) List<String> masteredCardIds,
    @Default([]) List<String> reviewLaterCardIds,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _QuizSession;

  factory QuizSession.fromJson(Map<String, dynamic> json) =>
      _$QuizSessionFromJson(json);
}