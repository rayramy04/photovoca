// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detected_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DetectedObject _$DetectedObjectFromJson(Map<String, dynamic> json) {
  return _DetectedObject.fromJson(json);
}

/// @nodoc
mixin _$DetectedObject {
  String get nameEn => throw _privateConstructorUsedError;
  String? get nameJa => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  RectJson? get boundingBox => throw _privateConstructorUsedError;

  /// Serializes this DetectedObject to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectedObjectCopyWith<DetectedObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectedObjectCopyWith<$Res> {
  factory $DetectedObjectCopyWith(
    DetectedObject value,
    $Res Function(DetectedObject) then,
  ) = _$DetectedObjectCopyWithImpl<$Res, DetectedObject>;
  @useResult
  $Res call({
    String nameEn,
    String? nameJa,
    double confidence,
    RectJson? boundingBox,
  });

  $RectJsonCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class _$DetectedObjectCopyWithImpl<$Res, $Val extends DetectedObject>
    implements $DetectedObjectCopyWith<$Res> {
  _$DetectedObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameEn = null,
    Object? nameJa = freezed,
    Object? confidence = null,
    Object? boundingBox = freezed,
  }) {
    return _then(
      _value.copyWith(
            nameEn: null == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String,
            nameJa: freezed == nameJa
                ? _value.nameJa
                : nameJa // ignore: cast_nullable_to_non_nullable
                      as String?,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            boundingBox: freezed == boundingBox
                ? _value.boundingBox
                : boundingBox // ignore: cast_nullable_to_non_nullable
                      as RectJson?,
          )
          as $Val,
    );
  }

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RectJsonCopyWith<$Res>? get boundingBox {
    if (_value.boundingBox == null) {
      return null;
    }

    return $RectJsonCopyWith<$Res>(_value.boundingBox!, (value) {
      return _then(_value.copyWith(boundingBox: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetectedObjectImplCopyWith<$Res>
    implements $DetectedObjectCopyWith<$Res> {
  factory _$$DetectedObjectImplCopyWith(
    _$DetectedObjectImpl value,
    $Res Function(_$DetectedObjectImpl) then,
  ) = __$$DetectedObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String nameEn,
    String? nameJa,
    double confidence,
    RectJson? boundingBox,
  });

  @override
  $RectJsonCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class __$$DetectedObjectImplCopyWithImpl<$Res>
    extends _$DetectedObjectCopyWithImpl<$Res, _$DetectedObjectImpl>
    implements _$$DetectedObjectImplCopyWith<$Res> {
  __$$DetectedObjectImplCopyWithImpl(
    _$DetectedObjectImpl _value,
    $Res Function(_$DetectedObjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameEn = null,
    Object? nameJa = freezed,
    Object? confidence = null,
    Object? boundingBox = freezed,
  }) {
    return _then(
      _$DetectedObjectImpl(
        nameEn: null == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String,
        nameJa: freezed == nameJa
            ? _value.nameJa
            : nameJa // ignore: cast_nullable_to_non_nullable
                  as String?,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        boundingBox: freezed == boundingBox
            ? _value.boundingBox
            : boundingBox // ignore: cast_nullable_to_non_nullable
                  as RectJson?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetectedObjectImpl implements _DetectedObject {
  const _$DetectedObjectImpl({
    required this.nameEn,
    this.nameJa,
    this.confidence = 0.0,
    this.boundingBox,
  });

  factory _$DetectedObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetectedObjectImplFromJson(json);

  @override
  final String nameEn;
  @override
  final String? nameJa;
  @override
  @JsonKey()
  final double confidence;
  @override
  final RectJson? boundingBox;

  @override
  String toString() {
    return 'DetectedObject(nameEn: $nameEn, nameJa: $nameJa, confidence: $confidence, boundingBox: $boundingBox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectedObjectImpl &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameJa, nameJa) || other.nameJa == nameJa) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nameEn, nameJa, confidence, boundingBox);

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectedObjectImplCopyWith<_$DetectedObjectImpl> get copyWith =>
      __$$DetectedObjectImplCopyWithImpl<_$DetectedObjectImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DetectedObjectImplToJson(this);
  }
}

abstract class _DetectedObject implements DetectedObject {
  const factory _DetectedObject({
    required final String nameEn,
    final String? nameJa,
    final double confidence,
    final RectJson? boundingBox,
  }) = _$DetectedObjectImpl;

  factory _DetectedObject.fromJson(Map<String, dynamic> json) =
      _$DetectedObjectImpl.fromJson;

  @override
  String get nameEn;
  @override
  String? get nameJa;
  @override
  double get confidence;
  @override
  RectJson? get boundingBox;

  /// Create a copy of DetectedObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectedObjectImplCopyWith<_$DetectedObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RectJson _$RectJsonFromJson(Map<String, dynamic> json) {
  return _RectJson.fromJson(json);
}

/// @nodoc
mixin _$RectJson {
  double get left => throw _privateConstructorUsedError;
  double get top => throw _privateConstructorUsedError;
  double get right => throw _privateConstructorUsedError;
  double get bottom => throw _privateConstructorUsedError;

  /// Serializes this RectJson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RectJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RectJsonCopyWith<RectJson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RectJsonCopyWith<$Res> {
  factory $RectJsonCopyWith(RectJson value, $Res Function(RectJson) then) =
      _$RectJsonCopyWithImpl<$Res, RectJson>;
  @useResult
  $Res call({double left, double top, double right, double bottom});
}

/// @nodoc
class _$RectJsonCopyWithImpl<$Res, $Val extends RectJson>
    implements $RectJsonCopyWith<$Res> {
  _$RectJsonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RectJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? right = null,
    Object? bottom = null,
  }) {
    return _then(
      _value.copyWith(
            left: null == left
                ? _value.left
                : left // ignore: cast_nullable_to_non_nullable
                      as double,
            top: null == top
                ? _value.top
                : top // ignore: cast_nullable_to_non_nullable
                      as double,
            right: null == right
                ? _value.right
                : right // ignore: cast_nullable_to_non_nullable
                      as double,
            bottom: null == bottom
                ? _value.bottom
                : bottom // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RectJsonImplCopyWith<$Res>
    implements $RectJsonCopyWith<$Res> {
  factory _$$RectJsonImplCopyWith(
    _$RectJsonImpl value,
    $Res Function(_$RectJsonImpl) then,
  ) = __$$RectJsonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double left, double top, double right, double bottom});
}

/// @nodoc
class __$$RectJsonImplCopyWithImpl<$Res>
    extends _$RectJsonCopyWithImpl<$Res, _$RectJsonImpl>
    implements _$$RectJsonImplCopyWith<$Res> {
  __$$RectJsonImplCopyWithImpl(
    _$RectJsonImpl _value,
    $Res Function(_$RectJsonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RectJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? right = null,
    Object? bottom = null,
  }) {
    return _then(
      _$RectJsonImpl(
        left: null == left
            ? _value.left
            : left // ignore: cast_nullable_to_non_nullable
                  as double,
        top: null == top
            ? _value.top
            : top // ignore: cast_nullable_to_non_nullable
                  as double,
        right: null == right
            ? _value.right
            : right // ignore: cast_nullable_to_non_nullable
                  as double,
        bottom: null == bottom
            ? _value.bottom
            : bottom // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RectJsonImpl implements _RectJson {
  const _$RectJsonImpl({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  factory _$RectJsonImpl.fromJson(Map<String, dynamic> json) =>
      _$$RectJsonImplFromJson(json);

  @override
  final double left;
  @override
  final double top;
  @override
  final double right;
  @override
  final double bottom;

  @override
  String toString() {
    return 'RectJson(left: $left, top: $top, right: $right, bottom: $bottom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RectJsonImpl &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.right, right) || other.right == right) &&
            (identical(other.bottom, bottom) || other.bottom == bottom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, left, top, right, bottom);

  /// Create a copy of RectJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RectJsonImplCopyWith<_$RectJsonImpl> get copyWith =>
      __$$RectJsonImplCopyWithImpl<_$RectJsonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RectJsonImplToJson(this);
  }
}

abstract class _RectJson implements RectJson {
  const factory _RectJson({
    required final double left,
    required final double top,
    required final double right,
    required final double bottom,
  }) = _$RectJsonImpl;

  factory _RectJson.fromJson(Map<String, dynamic> json) =
      _$RectJsonImpl.fromJson;

  @override
  double get left;
  @override
  double get top;
  @override
  double get right;
  @override
  double get bottom;

  /// Create a copy of RectJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RectJsonImplCopyWith<_$RectJsonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
