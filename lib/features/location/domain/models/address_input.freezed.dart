// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddressInput {

/// Province `codename` (GET /provinces).
 String? get provinceCode;/// Ward `codename` of [provinceCode]; reset when the province changes.
 String? get wardCode; String get houseNumber; GeoPoint? get point;
/// Create a copy of AddressInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressInputCopyWith<AddressInput> get copyWith => _$AddressInputCopyWithImpl<AddressInput>(this as AddressInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AddressInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressInput&&(identical(other.provinceCode, _this.provinceCode) || other.provinceCode == _this.provinceCode)&&(identical(other.wardCode, _this.wardCode) || other.wardCode == _this.wardCode)&&(identical(other.houseNumber, _this.houseNumber) || other.houseNumber == _this.houseNumber)&&(identical(other.point, _this.point) || other.point == _this.point));
}


@override
int get hashCode {
  final _this = this as AddressInput;
  return Object.hash(runtimeType,_this.provinceCode,_this.wardCode,_this.houseNumber,_this.point);
}

@override
String toString() {
  final _this = this as AddressInput;
  return 'AddressInput(provinceCode: ${_this.provinceCode}, wardCode: ${_this.wardCode}, houseNumber: ${_this.houseNumber}, point: ${_this.point})';
}


}

/// @nodoc
abstract mixin class $AddressInputCopyWith<$Res>  {
  factory $AddressInputCopyWith(AddressInput value, $Res Function(AddressInput) _then) = _$AddressInputCopyWithImpl;
@useResult
$Res call({
 String? provinceCode, String? wardCode, String houseNumber, GeoPoint? point
});




}
/// @nodoc
class _$AddressInputCopyWithImpl<$Res>
    implements $AddressInputCopyWith<$Res> {
  _$AddressInputCopyWithImpl(this._self, this._then);

  final AddressInput _self;
  final $Res Function(AddressInput) _then;

/// Create a copy of AddressInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provinceCode = freezed,Object? wardCode = freezed,Object? houseNumber = null,Object? point = freezed,}) {
  return _then(AddressInput(
provinceCode: freezed == provinceCode ? _self.provinceCode : provinceCode // ignore: cast_nullable_to_non_nullable
as String?,wardCode: freezed == wardCode ? _self.wardCode : wardCode // ignore: cast_nullable_to_non_nullable
as String?,houseNumber: null == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressInput].
extension AddressInputPatterns on AddressInput {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressInput() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressInput value)  $default,){
final _that = this;
switch (_that) {
case _AddressInput():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressInput value)?  $default,){
final _that = this;
switch (_that) {
case _AddressInput() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? provinceCode,  String? wardCode,  String houseNumber,  GeoPoint? point)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressInput() when $default != null:
return $default(_that.provinceCode,_that.wardCode,_that.houseNumber,_that.point);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? provinceCode,  String? wardCode,  String houseNumber,  GeoPoint? point)  $default,) {final _that = this;
switch (_that) {
case _AddressInput():
return $default(_that.provinceCode,_that.wardCode,_that.houseNumber,_that.point);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? provinceCode,  String? wardCode,  String houseNumber,  GeoPoint? point)?  $default,) {final _that = this;
switch (_that) {
case _AddressInput() when $default != null:
return $default(_that.provinceCode,_that.wardCode,_that.houseNumber,_that.point);case _:
  return null;

}
}

}

/// @nodoc


class _AddressInput extends AddressInput {
  const _AddressInput({this.provinceCode, this.wardCode, this.houseNumber = '', this.point}): super._();
  

/// Province `codename` (GET /provinces).
@override final  String? provinceCode;
/// Ward `codename` of [provinceCode]; reset when the province changes.
@override final  String? wardCode;
@override@JsonKey() final  String houseNumber;
@override final  GeoPoint? point;

/// Create a copy of AddressInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressInputCopyWith<_AddressInput> get copyWith => __$AddressInputCopyWithImpl<_AddressInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressInput&&(identical(other.provinceCode, provinceCode) || other.provinceCode == provinceCode)&&(identical(other.wardCode, wardCode) || other.wardCode == wardCode)&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.point, point) || other.point == point));
}


@override
int get hashCode {
    return Object.hash(runtimeType,provinceCode,wardCode,houseNumber,point);
}

@override
String toString() {
    return 'AddressInput(provinceCode: $provinceCode, wardCode: $wardCode, houseNumber: $houseNumber, point: $point)';
}


}

/// @nodoc
abstract mixin class _$AddressInputCopyWith<$Res> implements $AddressInputCopyWith<$Res> {
  factory _$AddressInputCopyWith(_AddressInput value, $Res Function(_AddressInput) _then) = __$AddressInputCopyWithImpl;
@override @useResult
$Res call({
 String? provinceCode, String? wardCode, String houseNumber, GeoPoint? point
});




}
/// @nodoc
class __$AddressInputCopyWithImpl<$Res>
    implements _$AddressInputCopyWith<$Res> {
  __$AddressInputCopyWithImpl(this._self, this._then);

  final _AddressInput _self;
  final $Res Function(_AddressInput) _then;

/// Create a copy of AddressInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provinceCode = freezed,Object? wardCode = freezed,Object? houseNumber = null,Object? point = freezed,}) {
  return _then(_AddressInput(
provinceCode: freezed == provinceCode ? _self.provinceCode : provinceCode // ignore: cast_nullable_to_non_nullable
as String?,wardCode: freezed == wardCode ? _self.wardCode : wardCode // ignore: cast_nullable_to_non_nullable
as String?,houseNumber: null == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as GeoPoint?,
  ));
}


}

// dart format on
