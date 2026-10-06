// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activate_form_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivateFormInput {

 LoginType get loginType; String get identifier; String get code;
/// Create a copy of ActivateFormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivateFormInputCopyWith<ActivateFormInput> get copyWith => _$ActivateFormInputCopyWithImpl<ActivateFormInput>(this as ActivateFormInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivateFormInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivateFormInput&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.code, _this.code) || other.code == _this.code));
}


@override
int get hashCode {
  final _this = this as ActivateFormInput;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.code);
}

@override
String toString() {
  final _this = this as ActivateFormInput;
  return 'ActivateFormInput(loginType: ${_this.loginType}, identifier: ${_this.identifier}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $ActivateFormInputCopyWith<$Res>  {
  factory $ActivateFormInputCopyWith(ActivateFormInput value, $Res Function(ActivateFormInput) _then) = _$ActivateFormInputCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, String code
});




}
/// @nodoc
class _$ActivateFormInputCopyWithImpl<$Res>
    implements $ActivateFormInputCopyWith<$Res> {
  _$ActivateFormInputCopyWithImpl(this._self, this._then);

  final ActivateFormInput _self;
  final $Res Function(ActivateFormInput) _then;

/// Create a copy of ActivateFormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? code = null,}) {
  return _then(ActivateFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivateFormInput].
extension ActivateFormInputPatterns on ActivateFormInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivateFormInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivateFormInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivateFormInput value)  $default,){
final _that = this;
switch (_that) {
case _ActivateFormInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivateFormInput value)?  $default,){
final _that = this;
switch (_that) {
case _ActivateFormInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivateFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String code)  $default,) {final _that = this;
switch (_that) {
case _ActivateFormInput():
return $default(_that.loginType,_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  String code)?  $default,) {final _that = this;
switch (_that) {
case _ActivateFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _ActivateFormInput extends ActivateFormInput {
  const _ActivateFormInput({required this.loginType, required this.identifier, required this.code}): super._();
  

@override final  LoginType loginType;
@override final  String identifier;
@override final  String code;

/// Create a copy of ActivateFormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivateFormInputCopyWith<_ActivateFormInput> get copyWith => __$ActivateFormInputCopyWithImpl<_ActivateFormInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivateFormInput&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,code);
}

@override
String toString() {
    return 'ActivateFormInput(loginType: $loginType, identifier: $identifier, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ActivateFormInputCopyWith<$Res> implements $ActivateFormInputCopyWith<$Res> {
  factory _$ActivateFormInputCopyWith(_ActivateFormInput value, $Res Function(_ActivateFormInput) _then) = __$ActivateFormInputCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, String code
});




}
/// @nodoc
class __$ActivateFormInputCopyWithImpl<$Res>
    implements _$ActivateFormInputCopyWith<$Res> {
  __$ActivateFormInputCopyWithImpl(this._self, this._then);

  final _ActivateFormInput _self;
  final $Res Function(_ActivateFormInput) _then;

/// Create a copy of ActivateFormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? code = null,}) {
  return _then(_ActivateFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
