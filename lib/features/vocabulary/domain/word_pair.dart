import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_pair.freezed.dart';
part 'word_pair.g.dart';

@freezed
class WordPair with _$WordPair {
  const factory WordPair({
    required String japanese,
    required String english,
    required String reading, // ひらがな読み
    @Default('') String category,
  }) = _WordPair;

  factory WordPair.fromJson(Map<String, dynamic> json) => _$WordPairFromJson(json);
}