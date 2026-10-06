// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

 String get id; LoginType get loginType; String? get email; String? get phone; String get username; UserRole get role; BusinessType? get bussinessType; String? get bussinessLicense; String? get avatar; String? get bio; DateTime get createdAt; DateTime get updatedAt; UserAddressDto? get address;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfileDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.bussinessType, _this.bussinessType) || other.bussinessType == _this.bussinessType)&&(identical(other.bussinessLicense, _this.bussinessLicense) || other.bussinessLicense == _this.bussinessLicense)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.address, _this.address) || other.address == _this.address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfileDto;
  return Object.hash(runtimeType,_this.id,_this.loginType,_this.email,_this.phone,_this.username,_this.role,_this.bussinessType,_this.bussinessLicense,_this.avatar,_this.bio,_this.createdAt,_this.updatedAt,_this.address);
}

@override
String toString() {
  final _this = this as UserProfileDto;
  return 'UserProfileDto(id: ${_this.id}, loginType: ${_this.loginType}, email: ${_this.email}, phone: ${_this.phone}, username: ${_this.username}, role: ${_this.role}, bussinessType: ${_this.bussinessType}, bussinessLicense: ${_this.bussinessLicense}, avatar: ${_this.avatar}, bio: ${_this.bio}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, address: ${_this.address})';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
 String id, LoginType loginType, String? email, String? phone, String username, UserRole role, BusinessType? bussinessType, String? bussinessLicense, String? avatar, String? bio, DateTime createdAt, DateTime updatedAt, UserAddressDto? address
});


$UserAddressDtoCopyWith<$Res>? get address;

}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? loginType = null,Object? email = freezed,Object? phone = freezed,Object? username = null,Object? role = null,Object? bussinessType = freezed,Object? bussinessLicense = freezed,Object? avatar = freezed,Object? bio = freezed,Object? createdAt = null,Object? updatedAt = null,Object? address = freezed,}) {
  return _then(UserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bussinessLicense: freezed == bussinessLicense ? _self.bussinessLicense : bussinessLicense // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as UserAddressDto?,
  ));
}
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAddressDtoCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $UserAddressDtoCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LoginType loginType,  String? email,  String? phone,  String username,  UserRole role,  BusinessType? bussinessType,  String? bussinessLicense,  String? avatar,  String? bio,  DateTime createdAt,  DateTime updatedAt,  UserAddressDto? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.loginType,_that.email,_that.phone,_that.username,_that.role,_that.bussinessType,_that.bussinessLicense,_that.avatar,_that.bio,_that.createdAt,_that.updatedAt,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LoginType loginType,  String? email,  String? phone,  String username,  UserRole role,  BusinessType? bussinessType,  String? bussinessLicense,  String? avatar,  String? bio,  DateTime createdAt,  DateTime updatedAt,  UserAddressDto? address)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.id,_that.loginType,_that.email,_that.phone,_that.username,_that.role,_that.bussinessType,_that.bussinessLicense,_that.avatar,_that.bio,_that.createdAt,_that.updatedAt,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LoginType loginType,  String? email,  String? phone,  String username,  UserRole role,  BusinessType? bussinessType,  String? bussinessLicense,  String? avatar,  String? bio,  DateTime createdAt,  DateTime updatedAt,  UserAddressDto? address)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.loginType,_that.email,_that.phone,_that.username,_that.role,_that.bussinessType,_that.bussinessLicense,_that.avatar,_that.bio,_that.createdAt,_that.updatedAt,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto implements UserProfileDto {
  const _UserProfileDto({required this.id, required this.loginType, required this.email, required this.phone, required this.username, required this.role, required this.bussinessType, required this.bussinessLicense, required this.avatar, required this.bio, required this.createdAt, required this.updatedAt, required this.address});
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

@override final  String id;
@override final  LoginType loginType;
@override final  String? email;
@override final  String? phone;
@override final  String username;
@override final  UserRole role;
@override final  BusinessType? bussinessType;
@override final  String? bussinessLicense;
@override final  String? avatar;
@override final  String? bio;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  UserAddressDto? address;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.bussinessType, bussinessType) || other.bussinessType == bussinessType)&&(identical(other.bussinessLicense, bussinessLicense) || other.bussinessLicense == bussinessLicense)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,loginType,email,phone,username,role,bussinessType,bussinessLicense,avatar,bio,createdAt,updatedAt,address);
}

@override
String toString() {
    return 'UserProfileDto(id: $id, loginType: $loginType, email: $email, phone: $phone, username: $username, role: $role, bussinessType: $bussinessType, bussinessLicense: $bussinessLicense, avatar: $avatar, bio: $bio, createdAt: $createdAt, updatedAt: $updatedAt, address: $address)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LoginType loginType, String? email, String? phone, String username, UserRole role, BusinessType? bussinessType, String? bussinessLicense, String? avatar, String? bio, DateTime createdAt, DateTime updatedAt, UserAddressDto? address
});


@override $UserAddressDtoCopyWith<$Res>? get address;

}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? loginType = null,Object? email = freezed,Object? phone = freezed,Object? username = null,Object? role = null,Object? bussinessType = freezed,Object? bussinessLicense = freezed,Object? avatar = freezed,Object? bio = freezed,Object? createdAt = null,Object? updatedAt = null,Object? address = freezed,}) {
  return _then(_UserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,bussinessType: freezed == bussinessType ? _self.bussinessType : bussinessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,bussinessLicense: freezed == bussinessLicense ? _self.bussinessLicense : bussinessLicense // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as UserAddressDto?,
  ));
}

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAddressDtoCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $UserAddressDtoCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$UserAddressDto {

 String get province; String get ward; String get houseNumber; double get lat; double get long;
/// Create a copy of UserAddressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAddressDtoCopyWith<UserAddressDto> get copyWith => _$UserAddressDtoCopyWithImpl<UserAddressDto>(this as UserAddressDto, _$identity);

  /// Serializes this UserAddressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserAddressDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddressDto&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.ward, _this.ward) || other.ward == _this.ward)&&(identical(other.houseNumber, _this.houseNumber) || other.houseNumber == _this.houseNumber)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.long, _this.long) || other.long == _this.long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserAddressDto;
  return Object.hash(runtimeType,_this.province,_this.ward,_this.houseNumber,_this.lat,_this.long);
}

@override
String toString() {
  final _this = this as UserAddressDto;
  return 'UserAddressDto(province: ${_this.province}, ward: ${_this.ward}, houseNumber: ${_this.houseNumber}, lat: ${_this.lat}, long: ${_this.long})';
}


}

/// @nodoc
abstract mixin class $UserAddressDtoCopyWith<$Res>  {
  factory $UserAddressDtoCopyWith(UserAddressDto value, $Res Function(UserAddressDto) _then) = _$UserAddressDtoCopyWithImpl;
@useResult
$Res call({
 String province, String ward, String houseNumber, double lat, double long
});




}
/// @nodoc
class _$UserAddressDtoCopyWithImpl<$Res>
    implements $UserAddressDtoCopyWith<$Res> {
  _$UserAddressDtoCopyWithImpl(this._self, this._then);

  final UserAddressDto _self;
  final $Res Function(UserAddressDto) _then;

/// Create a copy of UserAddressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? province = null,Object? ward = null,Object? houseNumber = null,Object? lat = null,Object? long = null,}) {
  return _then(UserAddressDto(
province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,houseNumber: null == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAddressDto].
extension UserAddressDtoPatterns on UserAddressDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAddressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAddressDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAddressDto value)  $default,){
final _that = this;
switch (_that) {
case _UserAddressDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAddressDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserAddressDto() when $default != null:
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
case _UserAddressDto() when $default != null:
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
case _UserAddressDto():
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
case _UserAddressDto() when $default != null:
return $default(_that.province,_that.ward,_that.houseNumber,_that.lat,_that.long);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAddressDto implements UserAddressDto {
  const _UserAddressDto({required this.province, required this.ward, required this.houseNumber, required this.lat, required this.long});
  factory _UserAddressDto.fromJson(Map<String, dynamic> json) => _$UserAddressDtoFromJson(json);

@override final  String province;
@override final  String ward;
@override final  String houseNumber;
@override final  double lat;
@override final  double long;

/// Create a copy of UserAddressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAddressDtoCopyWith<_UserAddressDto> get copyWith => __$UserAddressDtoCopyWithImpl<_UserAddressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAddressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAddressDto&&(identical(other.province, province) || other.province == province)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,province,ward,houseNumber,lat,long);
}

@override
String toString() {
    return 'UserAddressDto(province: $province, ward: $ward, houseNumber: $houseNumber, lat: $lat, long: $long)';
}


}

/// @nodoc
abstract mixin class _$UserAddressDtoCopyWith<$Res> implements $UserAddressDtoCopyWith<$Res> {
  factory _$UserAddressDtoCopyWith(_UserAddressDto value, $Res Function(_UserAddressDto) _then) = __$UserAddressDtoCopyWithImpl;
@override @useResult
$Res call({
 String province, String ward, String houseNumber, double lat, double long
});




}
/// @nodoc
class __$UserAddressDtoCopyWithImpl<$Res>
    implements _$UserAddressDtoCopyWith<$Res> {
  __$UserAddressDtoCopyWithImpl(this._self, this._then);

  final _UserAddressDto _self;
  final $Res Function(_UserAddressDto) _then;

/// Create a copy of UserAddressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? province = null,Object? ward = null,Object? houseNumber = null,Object? lat = null,Object? long = null,}) {
  return _then(_UserAddressDto(
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
