import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_card.freezed.dart';
part 'flash_card.g.dart';

@freezed
class FlashCard with _$FlashCard {
  const factory FlashCard({
    required String id,
    required String japanese,
    required String reading,
    required String english,
    @Default(false) bool isMastered,
    @Default(0) int reviewCount,
    DateTime? lastReviewedAt,
  }) = _FlashCard;

  factory FlashCard.fromJson(Map<String, dynamic> json) =>
      _$FlashCardFromJson(json);
}
