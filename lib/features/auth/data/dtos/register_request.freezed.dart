// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterRequest {

 LoginType get loginType; String get identifier; String get password;@JsonKey(includeIfNull: false) String? get username; UserRole get role;/// Required for DISTRIBUTOR, null for FARMER (sent as `null`).
 BusinessType? get bussinessType;@JsonKey(includeIfNull: false) String? get bio; RegisterAddressRequest get address;
/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestCopyWith<RegisterRequest> get copyWith => _$RegisterRequestCopyWithImpl<RegisterRequest>(this as RegisterRequest, _$identity);

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisterRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequest&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.bussinessType, _this.bussinessType) || other.bussinessType == _this.bussinessType)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.address, _this.address) || other.address == _this.address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisterRequest;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.password,_this.username,_this.role,_this.bussinessType,_this.bio,_this.address);
}

@override
String toString() {
  final _this = this as RegisterRequest;
  return 'RegisterRequest(loginType: ${_this.loginType}, identifier: ${_this.identifier}, password: ${_this.password}, username: ${_this.username}, role: ${_this.role}, bussinessType: ${_this.bussinessType}, bio: ${_this.bio}, address: ${_this.address})';
}


}

/// @nodoc
abstract mixin class $RegisterRequestCopyWith<$Res>  {
  factory $RegisterRequestCopyWith(RegisterRequest value, $Res Function(RegisterRequest) _then) = _$RegisterRequestCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, String password,@JsonKey(includeIfNull: false) String? username, UserRole role, BusinessType? bussinessType,@JsonKey(includeIfNull: false) String? bio, RegisterAddressRequest address
});


$RegisterAddressRequestCopyWith<$Res> get address;

}
/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._self, this._then);

  final RegisterRequest _self;
  final $Res Function(RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? username = freezed,Object? role = null,Object? bussinessType = freezed,Object? bio = freezed,Object? address = null,}) {
  return _then(RegisterRequest(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as RegisterAddressRequest,
  ));
}
/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterAddressRequestCopyWith<$Res> get address {
  
  return $RegisterAddressRequestCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterRequest].
extension RegisterRequestPatterns on RegisterRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password, @JsonKey(includeIfNull: false)  String? username,  UserRole role,  BusinessType? bussinessType, @JsonKey(includeIfNull: false)  String? bio,  RegisterAddressRequest address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  String password, @JsonKey(includeIfNull: false)  String? username,  UserRole role,  BusinessType? bussinessType, @JsonKey(includeIfNull: false)  String? bio,  RegisterAddressRequest address)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  String password, @JsonKey(includeIfNull: false)  String? username,  UserRole role,  BusinessType? bussinessType, @JsonKey(includeIfNull: false)  String? bio,  RegisterAddressRequest address)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
return $default(_that.loginType,_that.identifier,_that.password,_that.username,_that.role,_that.bussinessType,_that.bio,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequest implements RegisterRequest {
  const _RegisterRequest({required this.loginType, required this.identifier, required this.password, @JsonKey(includeIfNull: false) this.username, required this.role, this.bussinessType, @JsonKey(includeIfNull: false) this.bio, required this.address});
  factory _RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

@override final  LoginType loginType;
@override final  String identifier;
@override final  String password;
@override@JsonKey(includeIfNull: false) final  String? username;
@override final  UserRole role;
/// Required for DISTRIBUTOR, null for FARMER (sent as `null`).
@override final  BusinessType? bussinessType;
@override@JsonKey(includeIfNull: false) final  String? bio;
@override final  RegisterAddressRequest address;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestCopyWith<_RegisterRequest> get copyWith => __$RegisterRequestCopyWithImpl<_RegisterRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequest&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.bussinessType, bussinessType) || other.bussinessType == bussinessType)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,password,username,role,bussinessType,bio,address);
}

@override
String toString() {
    return 'RegisterRequest(loginType: $loginType, identifier: $identifier, password: $password, username: $username, role: $role, bussinessType: $bussinessType, bio: $bio, address: $address)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestCopyWith<$Res> implements $RegisterRequestCopyWith<$Res> {
  factory _$RegisterRequestCopyWith(_RegisterRequest value, $Res Function(_RegisterRequest) _then) = __$RegisterRequestCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, String password,@JsonKey(includeIfNull: false) String? username, UserRole role, BusinessType? bussinessType,@JsonKey(includeIfNull: false) String? bio, RegisterAddressRequest address
});


@override $RegisterAddressRequestCopyWith<$Res> get address;

}
/// @nodoc
class __$RegisterRequestCopyWithImpl<$Res>
    implements _$RegisterRequestCopyWith<$Res> {
  __$RegisterRequestCopyWithImpl(this._self, this._then);

  final _RegisterRequest _self;
  final $Res Function(_RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? password = null,Object? username = freezed,Object? role = null,Object? bussinessType = freezed,Object? bio = freezed,Object? address = null,}) {
  return _then(_RegisterRequest(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as RegisterAddressRequest,
  ));
}

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterAddressRequestCopyWith<$Res> get address {
  
  return $RegisterAddressRequestCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$RegisterAddressRequest {

 String get province; String get ward; String get houseNumber; double get lat; double get long;
/// Create a copy of RegisterAddressRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterAddressRequestCopyWith<RegisterAddressRequest> get copyWith => _$RegisterAddressRequestCopyWithImpl<RegisterAddressRequest>(this as RegisterAddressRequest, _$identity);

  /// Serializes this RegisterAddressRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisterAddressRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterAddressRequest&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.ward, _this.ward) || other.ward == _this.ward)&&(identical(other.houseNumber, _this.houseNumber) || other.houseNumber == _this.houseNumber)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.long, _this.long) || other.long == _this.long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisterAddressRequest;
  return Object.hash(runtimeType,_this.province,_this.ward,_this.houseNumber,_this.lat,_this.long);
}

@override
String toString() {
  final _this = this as RegisterAddressRequest;
  return 'RegisterAddressRequest(province: ${_this.province}, ward: ${_this.ward}, houseNumber: ${_this.houseNumber}, lat: ${_this.lat}, long: ${_this.long})';
}


}

/// @nodoc
abstract mixin class $RegisterAddressRequestCopyWith<$Res>  {
  factory $RegisterAddressRequestCopyWith(RegisterAddressRequest value, $Res Function(RegisterAddressRequest) _then) = _$RegisterAddressRequestCopyWithImpl;
@useResult
$Res call({
 String province, String ward, String houseNumber, double lat, double long
});




}
/// @nodoc
class _$RegisterAddressRequestCopyWithImpl<$Res>
    implements $RegisterAddressRequestCopyWith<$Res> {
  _$RegisterAddressRequestCopyWithImpl(this._self, this._then);

  final RegisterAddressRequest _self;
  final $Res Function(RegisterAddressRequest) _then;

/// Create a copy of RegisterAddressRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? province = null,Object? ward = null,Object? houseNumber = null,Object? lat = null,Object? long = null,}) {
  return _then(RegisterAddressRequest(
province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,houseNumber: null == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterAddressRequest].
extension RegisterAddressRequestPatterns on RegisterAddressRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterAddressRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterAddressRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterAddressRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterAddressRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterAddressRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterAddressRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String province,  String ward,  String houseNumber,  double lat,  double long)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterAddressRequest() when $default != null:
return $default(_that.province,_that.ward,_that.houseNumber,_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String province,  String ward,  String houseNumber,  double lat,  double long)  $default,) {final _that = this;
switch (_that) {
case _RegisterAddressRequest():
return $default(_that.province,_that.ward,_that.houseNumber,_that.lat,_that.long);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String province,  String ward,  String houseNumber,  double lat,  double long)?  $default,) {final _that = this;
switch (_that) {
case _RegisterAddressRequest() when $default != null:
return $default(_that.province,_that.ward,_that.houseNumber,_that.lat,_that.long);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterAddressRequest implements RegisterAddressRequest {
  const _RegisterAddressRequest({required this.province, required this.ward, required this.houseNumber, required this.lat, required this.long});
  factory _RegisterAddressRequest.fromJson(Map<String, dynamic> json) => _$RegisterAddressRequestFromJson(json);

@override final  String province;
@override final  String ward;
@override final  String houseNumber;
@override final  double lat;
@override final  double long;

/// Create a copy of RegisterAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterAddressRequestCopyWith<_RegisterAddressRequest> get copyWith => __$RegisterAddressRequestCopyWithImpl<_RegisterAddressRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterAddressRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterAddressRequest&&(identical(other.province, province) || other.province == province)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,province,ward,houseNumber,lat,long);
}

@override
String toString() {
    return 'RegisterAddressRequest(province: $province, ward: $ward, houseNumber: $houseNumber, lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class _$RegisterAddressRequestCopyWith<$Res> implements $RegisterAddressRequestCopyWith<$Res> {
  factory _$RegisterAddressRequestCopyWith(_RegisterAddressRequest value, $Res Function(_RegisterAddressRequest) _then) = __$RegisterAddressRequestCopyWithImpl;
@override @useResult
$Res call({
 String province, String ward, String houseNumber, double lat, double long
});




}
/// @nodoc
class __$RegisterAddressRequestCopyWithImpl<$Res>
    implements _$RegisterAddressRequestCopyWith<$Res> {
  __$RegisterAddressRequestCopyWithImpl(this._self, this._then);

  final _RegisterAddressRequest _self;
  final $Res Function(_RegisterAddressRequest) _then;

/// Create a copy of RegisterAddressRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? province = null,Object? ward = null,Object? houseNumber = null,Object? lat = null,Object? long = null,}) {
  return _then(_RegisterAddressRequest(
province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,houseNumber: null == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
