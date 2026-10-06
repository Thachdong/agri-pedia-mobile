// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_form_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterFormInput {

 LoginType get loginType; String get identifier; String get password; String get username; UserRole get role; BusinessType? get bussinessType; String get bio; AddressInput get address;
/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFormInputCopyWith<RegisterFormInput> get copyWith => _$RegisterFormInputCopyWithImpl<RegisterFormInput>(this as RegisterFormInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RegisterFormInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFormInput&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.bussinessType, _this.bussinessType) || other.bussinessType == _this.bussinessType)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.address, _this.address) || other.address == _this.address));
}


@override
int get hashCode {
  final _this = this as RegisterFormInput;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.password,_this.username,_this.role,_this.bussinessType,_this.bio,_this.address);
}

@override
String toString() {
  final _this = this as RegisterFormInput;
  return 'RegisterFormInput(loginType: ${_this.loginType}, identifier: ${_this.identifier}, password: ${_this.password}, username: ${_this.username}, role: ${_this.role}, bussinessType: ${_this.bussinessType}, bio: ${_this.bio}, address: ${_this.address})';
}


}

/// @nodoc
abstract mixin class $RegisterFormInputCopyWith<$Res>  {
  factory $RegisterFormInputCopyWith(RegisterFormInput value, $Res Function(RegisterFormInput) _then) = _$RegisterFormInputCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, String password, String username, UserRole role, BusinessType? bussinessType, String bio, AddressInput address
});


$AddressInputCopyWith<$Res> get address;

}
/// @nodoc
class _$RegisterFormInputCopyWithImpl<$Res>
    implements $RegisterFormInputCopyWith<$Res> {
  _$RegisterFormInputCopyWithImpl(this._self, this._then);

  final RegisterFormInput _self;
  final $Res Function(RegisterFormInput) _then;

/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? username = null,Object? role = null,Object? bussinessType = freezed,Object? bio = null,Object? address = null,}) {
  return _then(RegisterFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressInput,
  ));
}
/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressInputCopyWith<$Res> get address {
  
  return $AddressInputCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterFormInput].
extension RegisterFormInputPatterns on RegisterFormInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterFormInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterFormInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterFormInput value)  $default,){
final _that = this;
switch (_that) {
case _RegisterFormInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterFormInput value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterFormInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password,  String username,  UserRole role,  BusinessType? bussinessType,  String bio,  AddressInput address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password,_that.username,_that.role,_that.bussinessType,_that.bio,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password,  String username,  UserRole role,  BusinessType? bussinessType,  String bio,  AddressInput address)  $default,) {final _that = this;
switch (_that) {
case _RegisterFormInput():
return $default(_that.loginType,_that.identifier,_that.password,_that.username,_that.role,_that.bussinessType,_that.bio,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  String password,  String username,  UserRole role,  BusinessType? bussinessType,  String bio,  AddressInput address)?  $default,) {final _that = this;
switch (_that) {
case _RegisterFormInput() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password,_that.username,_that.role,_that.bussinessType,_that.bio,_that.address);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterFormInput extends RegisterFormInput {
  const _RegisterFormInput({required this.loginType, required this.identifier, required this.password, this.username = '', required this.role, this.bussinessType, this.bio = '', required this.address}): super._();
  

@override final  LoginType loginType;
@override final  String identifier;
@override final  String password;
@override@JsonKey() final  String username;
@override final  UserRole role;
@override final  BusinessType? bussinessType;
@override@JsonKey() final  String bio;
@override final  AddressInput address;

/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterFormInputCopyWith<_RegisterFormInput> get copyWith => __$RegisterFormInputCopyWithImpl<_RegisterFormInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterFormInput&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.bussinessType, bussinessType) || other.bussinessType == bussinessType)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,password,username,role,bussinessType,bio,address);
}

@override
String toString() {
    return 'RegisterFormInput(loginType: $loginType, identifier: $identifier, password: $password, username: $username, role: $role, bussinessType: $bussinessType, bio: $bio, address: $address)';
}


}

/// @nodoc
abstract mixin class _$RegisterFormInputCopyWith<$Res> implements $RegisterFormInputCopyWith<$Res> {
  factory _$RegisterFormInputCopyWith(_RegisterFormInput value, $Res Function(_RegisterFormInput) _then) = __$RegisterFormInputCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, String password, String username, UserRole role, BusinessType? bussinessType, String bio, AddressInput address
});


@override $AddressInputCopyWith<$Res> get address;

}
/// @nodoc
class __$RegisterFormInputCopyWithImpl<$Res>
    implements _$RegisterFormInputCopyWith<$Res> {
  __$RegisterFormInputCopyWithImpl(this._self, this._then);

  final _RegisterFormInput _self;
  final $Res Function(_RegisterFormInput) _then;

/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? username = null,Object? role = null,Object? bussinessType = freezed,Object? bio = null,Object? address = null,}) {
  return _then(_RegisterFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressInput,
  ));
}

/// Create a copy of RegisterFormInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressInputCopyWith<$Res> get address {
  
  return $AddressInputCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
