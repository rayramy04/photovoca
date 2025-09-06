// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordPairImpl _$$WordPairImplFromJson(Map<String, dynamic> json) =>
    _$WordPairImpl(
      japanese: json['japanese'] as String,
      english: json['english'] as String,
      reading: json['reading'] as String,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$$WordPairImplToJson(_$WordPairImpl instance) =>
    <String, dynamic>{
      'japanese': instance.japanese,
      'english': instance.english,
      'reading': instance.reading,
      'category': instance.category,
    };
