// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizSessionImpl _$$QuizSessionImplFromJson(Map<String, dynamic> json) =>
    _$QuizSessionImpl(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => FlashCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: $enumDecode(_$QuizModeEnumMap, json['mode']),
      currentIndex: (json['currentIndex'] as num?)?.toInt() ?? 0,
      masteredCardIds:
          (json['masteredCardIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reviewLaterCardIds:
          (json['reviewLaterCardIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$QuizSessionImplToJson(_$QuizSessionImpl instance) =>
    <String, dynamic>{
      'cards': instance.cards,
      'mode': _$QuizModeEnumMap[instance.mode]!,
      'currentIndex': instance.currentIndex,
      'masteredCardIds': instance.masteredCardIds,
      'reviewLaterCardIds': instance.reviewLaterCardIds,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$QuizModeEnumMap = {
  QuizMode.japaneseToEnglish: 'japaneseToEnglish',
  QuizMode.englishToJapanese: 'englishToJapanese',
};
