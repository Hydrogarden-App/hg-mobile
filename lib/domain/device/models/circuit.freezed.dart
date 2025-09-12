// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circuit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Circuit _$CircuitFromJson(Map<String, dynamic> json) {
  return _Circuit.fromJson(json);
}

/// @nodoc
mixin _$Circuit {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get state => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get desiredState => throw _privateConstructorUsedError;

  /// Serializes this Circuit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CircuitCopyWith<Circuit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CircuitCopyWith<$Res> {
  factory $CircuitCopyWith(Circuit value, $Res Function(Circuit) then) =
      _$CircuitCopyWithImpl<$Res, Circuit>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) bool state,
      @HiveField(3) bool desiredState});
}

/// @nodoc
class _$CircuitCopyWithImpl<$Res, $Val extends Circuit>
    implements $CircuitCopyWith<$Res> {
  _$CircuitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? desiredState = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      desiredState: null == desiredState
          ? _value.desiredState
          : desiredState // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CircuitImplCopyWith<$Res> implements $CircuitCopyWith<$Res> {
  factory _$$CircuitImplCopyWith(
          _$CircuitImpl value, $Res Function(_$CircuitImpl) then) =
      __$$CircuitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) bool state,
      @HiveField(3) bool desiredState});
}

/// @nodoc
class __$$CircuitImplCopyWithImpl<$Res>
    extends _$CircuitCopyWithImpl<$Res, _$CircuitImpl>
    implements _$$CircuitImplCopyWith<$Res> {
  __$$CircuitImplCopyWithImpl(
      _$CircuitImpl _value, $Res Function(_$CircuitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? desiredState = null,
  }) {
    return _then(_$CircuitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      desiredState: null == desiredState
          ? _value.desiredState
          : desiredState // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CircuitImpl implements _Circuit {
  const _$CircuitImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.state,
      @HiveField(3) required this.desiredState});

  factory _$CircuitImpl.fromJson(Map<String, dynamic> json) =>
      _$$CircuitImplFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final bool state;
  @override
  @HiveField(3)
  final bool desiredState;

  @override
  String toString() {
    return 'Circuit(id: $id, name: $name, state: $state, desiredState: $desiredState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CircuitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.desiredState, desiredState) ||
                other.desiredState == desiredState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, state, desiredState);

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      __$$CircuitImplCopyWithImpl<_$CircuitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CircuitImplToJson(
      this,
    );
  }
}

abstract class _Circuit implements Circuit {
  const factory _Circuit(
      {@HiveField(0) required final int id,
      @HiveField(1) required final String name,
      @HiveField(2) required final bool state,
      @HiveField(3) required final bool desiredState}) = _$CircuitImpl;

  factory _Circuit.fromJson(Map<String, dynamic> json) = _$CircuitImpl.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  bool get state;
  @override
  @HiveField(3)
  bool get desiredState;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
