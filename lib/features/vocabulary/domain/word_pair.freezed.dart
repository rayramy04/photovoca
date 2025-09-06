// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WordPair _$WordPairFromJson(Map<String, dynamic> json) {
  return _WordPair.fromJson(json);
}

/// @nodoc
mixin _$WordPair {
  String get japanese => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  String get reading => throw _privateConstructorUsedError; // ひらがな読み
  String get category => throw _privateConstructorUsedError;

  /// Serializes this WordPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordPairCopyWith<WordPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordPairCopyWith<$Res> {
  factory $WordPairCopyWith(WordPair value, $Res Function(WordPair) then) =
      _$WordPairCopyWithImpl<$Res, WordPair>;
  @useResult
  $Res call({String japanese, String english, String reading, String category});
}

/// @nodoc
class _$WordPairCopyWithImpl<$Res, $Val extends WordPair>
    implements $WordPairCopyWith<$Res> {
  _$WordPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? japanese = null,
    Object? english = null,
    Object? reading = null,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            japanese: null == japanese
                ? _value.japanese
                : japanese // ignore: cast_nullable_to_non_nullable
                      as String,
            english: null == english
                ? _value.english
                : english // ignore: cast_nullable_to_non_nullable
                      as String,
            reading: null == reading
                ? _value.reading
                : reading // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordPairImplCopyWith<$Res>
    implements $WordPairCopyWith<$Res> {
  factory _$$WordPairImplCopyWith(
    _$WordPairImpl value,
    $Res Function(_$WordPairImpl) then,
  ) = __$$WordPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String japanese, String english, String reading, String category});
}

/// @nodoc
class __$$WordPairImplCopyWithImpl<$Res>
    extends _$WordPairCopyWithImpl<$Res, _$WordPairImpl>
    implements _$$WordPairImplCopyWith<$Res> {
  __$$WordPairImplCopyWithImpl(
    _$WordPairImpl _value,
    $Res Function(_$WordPairImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WordPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? japanese = null,
    Object? english = null,
    Object? reading = null,
    Object? category = null,
  }) {
    return _then(
      _$WordPairImpl(
        japanese: null == japanese
            ? _value.japanese
            : japanese // ignore: cast_nullable_to_non_nullable
                  as String,
        english: null == english
            ? _value.english
            : english // ignore: cast_nullable_to_non_nullable
                  as String,
        reading: null == reading
            ? _value.reading
            : reading // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordPairImpl implements _WordPair {
  const _$WordPairImpl({
    required this.japanese,
    required this.english,
    required this.reading,
    this.category = '',
  });

  factory _$WordPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordPairImplFromJson(json);

  @override
  final String japanese;
  @override
  final String english;
  @override
  final String reading;
  // ひらがな読み
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'WordPair(japanese: $japanese, english: $english, reading: $reading, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordPairImpl &&
            (identical(other.japanese, japanese) ||
                other.japanese == japanese) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.reading, reading) || other.reading == reading) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, japanese, english, reading, category);

  /// Create a copy of WordPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordPairImplCopyWith<_$WordPairImpl> get copyWith =>
      __$$WordPairImplCopyWithImpl<_$WordPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordPairImplToJson(this);
  }
}

abstract class _WordPair implements WordPair {
  const factory _WordPair({
    required final String japanese,
    required final String english,
    required final String reading,
    final String category,
  }) = _$WordPairImpl;

  factory _WordPair.fromJson(Map<String, dynamic> json) =
      _$WordPairImpl.fromJson;

  @override
  String get japanese;
  @override
  String get english;
  @override
  String get reading; // ひらがな読み
  @override
  String get category;

  /// Create a copy of WordPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordPairImplCopyWith<_$WordPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
