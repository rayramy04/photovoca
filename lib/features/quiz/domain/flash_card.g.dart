// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlashCardImpl _$$FlashCardImplFromJson(Map<String, dynamic> json) =>
    _$FlashCardImpl(
      id: json['id'] as String,
      japanese: json['japanese'] as String,
      reading: json['reading'] as String,
      english: json['english'] as String,
      isMastered: json['isMastered'] as bool? ?? false,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      lastReviewedAt: json['lastReviewedAt'] == null
          ? null
          : DateTime.parse(json['lastReviewedAt'] as String),
    );

Map<String, dynamic> _$$FlashCardImplToJson(_$FlashCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'japanese': instance.japanese,
      'reading': instance.reading,
      'english': instance.english,
      'isMastered': instance.isMastered,
      'reviewCount': instance.reviewCount,
      'lastReviewedAt': instance.lastReviewedAt?.toIso8601String(),
    };
