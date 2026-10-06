// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_form_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordFormInput {

 LoginType get loginType; String get identifier; String get password; String get code;
/// Create a copy of ChangePasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordFormInputCopyWith<ChangePasswordFormInput> get copyWith => _$ChangePasswordFormInputCopyWithImpl<ChangePasswordFormInput>(this as ChangePasswordFormInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChangePasswordFormInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordFormInput&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.code, _this.code) || other.code == _this.code));
}


@override
int get hashCode {
  final _this = this as ChangePasswordFormInput;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.password,_this.code);
}

@override
String toString() {
  final _this = this as ChangePasswordFormInput;
  return 'ChangePasswordFormInput(loginType: ${_this.loginType}, identifier: ${_this.identifier}, password: ${_this.password}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $ChangePasswordFormInputCopyWith<$Res>  {
  factory $ChangePasswordFormInputCopyWith(ChangePasswordFormInput value, $Res Function(ChangePasswordFormInput) _then) = _$ChangePasswordFormInputCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, String password, String code
});




}
/// @nodoc
class _$ChangePasswordFormInputCopyWithImpl<$Res>
    implements $ChangePasswordFormInputCopyWith<$Res> {
  _$ChangePasswordFormInputCopyWithImpl(this._self, this._then);

  final ChangePasswordFormInput _self;
  final $Res Function(ChangePasswordFormInput) _then;

/// Create a copy of ChangePasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? code = null,}) {
  return _then(ChangePasswordFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordFormInput].
extension ChangePasswordFormInputPatterns on ChangePasswordFormInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordFormInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordFormInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordFormInput value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordFormInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordFormInput value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordFormInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password,  String code)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordFormInput():
return $default(_that.loginType,_that.identifier,_that.password,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  String password,  String code)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _ChangePasswordFormInput extends ChangePasswordFormInput {
  const _ChangePasswordFormInput({required this.loginType, required this.identifier, required this.password, required this.code}): super._();
  

@override final  LoginType loginType;
@override final  String identifier;
@override final  String password;
@override final  String code;

/// Create a copy of ChangePasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordFormInputCopyWith<_ChangePasswordFormInput> get copyWith => __$ChangePasswordFormInputCopyWithImpl<_ChangePasswordFormInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordFormInput&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,password,code);
}

@override
String toString() {
    return 'ChangePasswordFormInput(loginType: $loginType, identifier: $identifier, password: $password, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordFormInputCopyWith<$Res> implements $ChangePasswordFormInputCopyWith<$Res> {
  factory _$ChangePasswordFormInputCopyWith(_ChangePasswordFormInput value, $Res Function(_ChangePasswordFormInput) _then) = __$ChangePasswordFormInputCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, String password, String code
});




}
/// @nodoc
class __$ChangePasswordFormInputCopyWithImpl<$Res>
    implements _$ChangePasswordFormInputCopyWith<$Res> {
  __$ChangePasswordFormInputCopyWithImpl(this._self, this._then);

  final _ChangePasswordFormInput _self;
  final $Res Function(_ChangePasswordFormInput) _then;

/// Create a copy of ChangePasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? code = null,}) {
  return _then(_ChangePasswordFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
