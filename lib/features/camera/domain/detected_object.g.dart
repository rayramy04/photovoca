// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detected_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetectedObjectImpl _$$DetectedObjectImplFromJson(Map<String, dynamic> json) =>
    _$DetectedObjectImpl(
      nameEn: json['nameEn'] as String,
      nameJa: json['nameJa'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      boundingBox: json['boundingBox'] == null
          ? null
          : RectJson.fromJson(json['boundingBox'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetectedObjectImplToJson(
  _$DetectedObjectImpl instance,
) => <String, dynamic>{
  'nameEn': instance.nameEn,
  'nameJa': instance.nameJa,
  'confidence': instance.confidence,
  'boundingBox': instance.boundingBox,
};

_$RectJsonImpl _$$RectJsonImplFromJson(Map<String, dynamic> json) =>
    _$RectJsonImpl(
      left: (json['left'] as num).toDouble(),
      top: (json['top'] as num).toDouble(),
      right: (json['right'] as num).toDouble(),
      bottom: (json['bottom'] as num).toDouble(),
    );

Map<String, dynamic> _$$RectJsonImplToJson(_$RectJsonImpl instance) =>
    <String, dynamic>{
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };
