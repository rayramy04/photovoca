// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizSession _$QuizSessionFromJson(Map<String, dynamic> json) {
  return _QuizSession.fromJson(json);
}

/// @nodoc
mixin _$QuizSession {
  List<FlashCard> get cards => throw _privateConstructorUsedError;
  QuizMode get mode => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<String> get masteredCardIds => throw _privateConstructorUsedError;
  List<String> get reviewLaterCardIds => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this QuizSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizSessionCopyWith<QuizSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizSessionCopyWith<$Res> {
  factory $QuizSessionCopyWith(
    QuizSession value,
    $Res Function(QuizSession) then,
  ) = _$QuizSessionCopyWithImpl<$Res, QuizSession>;
  @useResult
  $Res call({
    List<FlashCard> cards,
    QuizMode mode,
    int currentIndex,
    List<String> masteredCardIds,
    List<String> reviewLaterCardIds,
    DateTime? startedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$QuizSessionCopyWithImpl<$Res, $Val extends QuizSession>
    implements $QuizSessionCopyWith<$Res> {
  _$QuizSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? mode = null,
    Object? currentIndex = null,
    Object? masteredCardIds = null,
    Object? reviewLaterCardIds = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<FlashCard>,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as QuizMode,
            currentIndex: null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            masteredCardIds: null == masteredCardIds
                ? _value.masteredCardIds
                : masteredCardIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            reviewLaterCardIds: null == reviewLaterCardIds
                ? _value.reviewLaterCardIds
                : reviewLaterCardIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizSessionImplCopyWith<$Res>
    implements $QuizSessionCopyWith<$Res> {
  factory _$$QuizSessionImplCopyWith(
    _$QuizSessionImpl value,
    $Res Function(_$QuizSessionImpl) then,
  ) = __$$QuizSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<FlashCard> cards,
    QuizMode mode,
    int currentIndex,
    List<String> masteredCardIds,
    List<String> reviewLaterCardIds,
    DateTime? startedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$QuizSessionImplCopyWithImpl<$Res>
    extends _$QuizSessionCopyWithImpl<$Res, _$QuizSessionImpl>
    implements _$$QuizSessionImplCopyWith<$Res> {
  __$$QuizSessionImplCopyWithImpl(
    _$QuizSessionImpl _value,
    $Res Function(_$QuizSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? mode = null,
    Object? currentIndex = null,
    Object? masteredCardIds = null,
    Object? reviewLaterCardIds = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$QuizSessionImpl(
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<FlashCard>,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as QuizMode,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        masteredCardIds: null == masteredCardIds
            ? _value._masteredCardIds
            : masteredCardIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        reviewLaterCardIds: null == reviewLaterCardIds
            ? _value._reviewLaterCardIds
            : reviewLaterCardIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizSessionImpl implements _QuizSession {
  const _$QuizSessionImpl({
    required final List<FlashCard> cards,
    required this.mode,
    this.currentIndex = 0,
    final List<String> masteredCardIds = const [],
    final List<String> reviewLaterCardIds = const [],
    this.startedAt,
    this.completedAt,
  }) : _cards = cards,
       _masteredCardIds = masteredCardIds,
       _reviewLaterCardIds = reviewLaterCardIds;

  factory _$QuizSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizSessionImplFromJson(json);

  final List<FlashCard> _cards;
  @override
  List<FlashCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final QuizMode mode;
  @override
  @JsonKey()
  final int currentIndex;
  final List<String> _masteredCardIds;
  @override
  @JsonKey()
  List<String> get masteredCardIds {
    if (_masteredCardIds is EqualUnmodifiableListView) return _masteredCardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_masteredCardIds);
  }

  final List<String> _reviewLaterCardIds;
  @override
  @JsonKey()
  List<String> get reviewLaterCardIds {
    if (_reviewLaterCardIds is EqualUnmodifiableListView)
      return _reviewLaterCardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewLaterCardIds);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'QuizSession(cards: $cards, mode: $mode, currentIndex: $currentIndex, masteredCardIds: $masteredCardIds, reviewLaterCardIds: $reviewLaterCardIds, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizSessionImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality().equals(
              other._masteredCardIds,
              _masteredCardIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._reviewLaterCardIds,
              _reviewLaterCardIds,
            ) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_cards),
    mode,
    currentIndex,
    const DeepCollectionEquality().hash(_masteredCardIds),
    const DeepCollectionEquality().hash(_reviewLaterCardIds),
    startedAt,
    completedAt,
  );

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizSessionImplCopyWith<_$QuizSessionImpl> get copyWith =>
      __$$QuizSessionImplCopyWithImpl<_$QuizSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizSessionImplToJson(this);
  }
}

abstract class _QuizSession implements QuizSession {
  const factory _QuizSession({
    required final List<FlashCard> cards,
    required final QuizMode mode,
    final int currentIndex,
    final List<String> masteredCardIds,
    final List<String> reviewLaterCardIds,
    final DateTime? startedAt,
    final DateTime? completedAt,
  }) = _$QuizSessionImpl;

  factory _QuizSession.fromJson(Map<String, dynamic> json) =
      _$QuizSessionImpl.fromJson;

  @override
  List<FlashCard> get cards;
  @override
  QuizMode get mode;
  @override
  int get currentIndex;
  @override
  List<String> get masteredCardIds;
  @override
  List<String> get reviewLaterCardIds;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizSessionImplCopyWith<_$QuizSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
