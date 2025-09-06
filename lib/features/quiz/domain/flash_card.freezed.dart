// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flash_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FlashCard _$FlashCardFromJson(Map<String, dynamic> json) {
  return _FlashCard.fromJson(json);
}

/// @nodoc
mixin _$FlashCard {
  String get id => throw _privateConstructorUsedError;
  String get japanese => throw _privateConstructorUsedError;
  String get reading => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  bool get isMastered => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  DateTime? get lastReviewedAt => throw _privateConstructorUsedError;

  /// Serializes this FlashCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlashCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashCardCopyWith<FlashCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashCardCopyWith<$Res> {
  factory $FlashCardCopyWith(FlashCard value, $Res Function(FlashCard) then) =
      _$FlashCardCopyWithImpl<$Res, FlashCard>;
  @useResult
  $Res call({
    String id,
    String japanese,
    String reading,
    String english,
    bool isMastered,
    int reviewCount,
    DateTime? lastReviewedAt,
  });
}

/// @nodoc
class _$FlashCardCopyWithImpl<$Res, $Val extends FlashCard>
    implements $FlashCardCopyWith<$Res> {
  _$FlashCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlashCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? japanese = null,
    Object? reading = null,
    Object? english = null,
    Object? isMastered = null,
    Object? reviewCount = null,
    Object? lastReviewedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            japanese: null == japanese
                ? _value.japanese
                : japanese // ignore: cast_nullable_to_non_nullable
                      as String,
            reading: null == reading
                ? _value.reading
                : reading // ignore: cast_nullable_to_non_nullable
                      as String,
            english: null == english
                ? _value.english
                : english // ignore: cast_nullable_to_non_nullable
                      as String,
            isMastered: null == isMastered
                ? _value.isMastered
                : isMastered // ignore: cast_nullable_to_non_nullable
                      as bool,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastReviewedAt: freezed == lastReviewedAt
                ? _value.lastReviewedAt
                : lastReviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashCardImplCopyWith<$Res>
    implements $FlashCardCopyWith<$Res> {
  factory _$$FlashCardImplCopyWith(
    _$FlashCardImpl value,
    $Res Function(_$FlashCardImpl) then,
  ) = __$$FlashCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String japanese,
    String reading,
    String english,
    bool isMastered,
    int reviewCount,
    DateTime? lastReviewedAt,
  });
}

/// @nodoc
class __$$FlashCardImplCopyWithImpl<$Res>
    extends _$FlashCardCopyWithImpl<$Res, _$FlashCardImpl>
    implements _$$FlashCardImplCopyWith<$Res> {
  __$$FlashCardImplCopyWithImpl(
    _$FlashCardImpl _value,
    $Res Function(_$FlashCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlashCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? japanese = null,
    Object? reading = null,
    Object? english = null,
    Object? isMastered = null,
    Object? reviewCount = null,
    Object? lastReviewedAt = freezed,
  }) {
    return _then(
      _$FlashCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        japanese: null == japanese
            ? _value.japanese
            : japanese // ignore: cast_nullable_to_non_nullable
                  as String,
        reading: null == reading
            ? _value.reading
            : reading // ignore: cast_nullable_to_non_nullable
                  as String,
        english: null == english
            ? _value.english
            : english // ignore: cast_nullable_to_non_nullable
                  as String,
        isMastered: null == isMastered
            ? _value.isMastered
            : isMastered // ignore: cast_nullable_to_non_nullable
                  as bool,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastReviewedAt: freezed == lastReviewedAt
            ? _value.lastReviewedAt
            : lastReviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlashCardImpl implements _FlashCard {
  const _$FlashCardImpl({
    required this.id,
    required this.japanese,
    required this.reading,
    required this.english,
    this.isMastered = false,
    this.reviewCount = 0,
    this.lastReviewedAt,
  });

  factory _$FlashCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlashCardImplFromJson(json);

  @override
  final String id;
  @override
  final String japanese;
  @override
  final String reading;
  @override
  final String english;
  @override
  @JsonKey()
  final bool isMastered;
  @override
  @JsonKey()
  final int reviewCount;
  @override
  final DateTime? lastReviewedAt;

  @override
  String toString() {
    return 'FlashCard(id: $id, japanese: $japanese, reading: $reading, english: $english, isMastered: $isMastered, reviewCount: $reviewCount, lastReviewedAt: $lastReviewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.japanese, japanese) ||
                other.japanese == japanese) &&
            (identical(other.reading, reading) || other.reading == reading) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.isMastered, isMastered) ||
                other.isMastered == isMastered) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.lastReviewedAt, lastReviewedAt) ||
                other.lastReviewedAt == lastReviewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    japanese,
    reading,
    english,
    isMastered,
    reviewCount,
    lastReviewedAt,
  );

  /// Create a copy of FlashCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashCardImplCopyWith<_$FlashCardImpl> get copyWith =>
      __$$FlashCardImplCopyWithImpl<_$FlashCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlashCardImplToJson(this);
  }
}

abstract class _FlashCard implements FlashCard {
  const factory _FlashCard({
    required final String id,
    required final String japanese,
    required final String reading,
    required final String english,
    final bool isMastered,
    final int reviewCount,
    final DateTime? lastReviewedAt,
  }) = _$FlashCardImpl;

  factory _FlashCard.fromJson(Map<String, dynamic> json) =
      _$FlashCardImpl.fromJson;

  @override
  String get id;
  @override
  String get japanese;
  @override
  String get reading;
  @override
  String get english;
  @override
  bool get isMastered;
  @override
  int get reviewCount;
  @override
  DateTime? get lastReviewedAt;

  /// Create a copy of FlashCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashCardImplCopyWith<_$FlashCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
