import 'package:freezed_annotation/freezed_annotation.dart';

part 'detected_object.freezed.dart';
part 'detected_object.g.dart';

@freezed
class DetectedObject with _$DetectedObject {
  const factory DetectedObject({
    required String nameEn,
    String? nameJa,
    @Default(0.0) double confidence,
    RectJson? boundingBox,
  }) = _DetectedObject;

  factory DetectedObject.fromJson(Map<String, dynamic> json) =>
      _$DetectedObjectFromJson(json);
}

@freezed
class RectJson with _$RectJson {
  const factory RectJson({
    required double left,
    required double top,
    required double right,
    required double bottom,
  }) = _RectJson;

  factory RectJson.fromJson(Map<String, dynamic> json) =>
      _$RectJsonFromJson(json);
}

