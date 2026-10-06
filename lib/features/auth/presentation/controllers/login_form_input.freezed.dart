// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormInput {

 LoginType get loginType; String get identifier; String get password;
/// Create a copy of LoginFormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormInputCopyWith<LoginFormInput> get copyWith => _$LoginFormInputCopyWithImpl<LoginFormInput>(this as LoginFormInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginFormInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormInput&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.password, _this.password) || other.password == _this.password));
}


@override
int get hashCode {
  final _this = this as LoginFormInput;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.password);
}

@override
String toString() {
  final _this = this as LoginFormInput;
  return 'LoginFormInput(loginType: ${_this.loginType}, identifier: ${_this.identifier}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $LoginFormInputCopyWith<$Res>  {
  factory $LoginFormInputCopyWith(LoginFormInput value, $Res Function(LoginFormInput) _then) = _$LoginFormInputCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, String password
});




}
/// @nodoc
class _$LoginFormInputCopyWithImpl<$Res>
    implements $LoginFormInputCopyWith<$Res> {
  _$LoginFormInputCopyWithImpl(this._self, this._then);

  final LoginFormInput _self;
  final $Res Function(LoginFormInput) _then;

/// Create a copy of LoginFormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,}) {
  return _then(LoginFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginFormInput].
extension LoginFormInputPatterns on LoginFormInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginFormInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginFormInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginFormInput value)  $default,){
final _that = this;
switch (_that) {
case _LoginFormInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginFormInput value)?  $default,){
final _that = this;
switch (_that) {
case _LoginFormInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password)  $default,) {final _that = this;
switch (_that) {
case _LoginFormInput():
return $default(_that.loginType,_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  String password)?  $default,) {final _that = this;
switch (_that) {
case _LoginFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _LoginFormInput extends LoginFormInput {
  const _LoginFormInput({required this.loginType, required this.identifier, required this.password}): super._();
  

@override final  LoginType loginType;
@override final  String identifier;
@override final  String password;

/// Create a copy of LoginFormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormInputCopyWith<_LoginFormInput> get copyWith => __$LoginFormInputCopyWithImpl<_LoginFormInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormInput&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,password);
}

@override
String toString() {
    return 'LoginFormInput(loginType: $loginType, identifier: $identifier, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginFormInputCopyWith<$Res> implements $LoginFormInputCopyWith<$Res> {
  factory _$LoginFormInputCopyWith(_LoginFormInput value, $Res Function(_LoginFormInput) _then) = __$LoginFormInputCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, String password
});




}
/// @nodoc
class __$LoginFormInputCopyWithImpl<$Res>
    implements _$LoginFormInputCopyWith<$Res> {
  __$LoginFormInputCopyWithImpl(this._self, this._then);

  final _LoginFormInput _self;
  final $Res Function(_LoginFormInput) _then;

/// Create a copy of LoginFormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,}) {
  return _then(_LoginFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
