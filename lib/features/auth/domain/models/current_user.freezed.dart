// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentUser {

 String get id; LoginType get loginType;/// Email or phone, per [loginType].
 String get identifier; String get username; UserRole get role; BusinessType? get businessType; String? get avatar; String? get bio;
/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<CurrentUser> get copyWith => _$CurrentUserCopyWithImpl<CurrentUser>(this as CurrentUser, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CurrentUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.businessType, _this.businessType) || other.businessType == _this.businessType)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.bio, _this.bio) || other.bio == _this.bio));
}


@override
int get hashCode {
  final _this = this as CurrentUser;
  return Object.hash(runtimeType,_this.id,_this.loginType,_this.identifier,_this.username,_this.role,_this.businessType,_this.avatar,_this.bio);
}

@override
String toString() {
  final _this = this as CurrentUser;
  return 'CurrentUser(id: ${_this.id}, loginType: ${_this.loginType}, identifier: ${_this.identifier}, username: ${_this.username}, role: ${_this.role}, businessType: ${_this.businessType}, avatar: ${_this.avatar}, bio: ${_this.bio})';
}


}

/// @nodoc
abstract mixin class $CurrentUserCopyWith<$Res>  {
  factory $CurrentUserCopyWith(CurrentUser value, $Res Function(CurrentUser) _then) = _$CurrentUserCopyWithImpl;
@useResult
$Res call({
 String id, LoginType loginType, String identifier, String username, UserRole role, BusinessType? businessType, String? avatar, String? bio
});




}
/// @nodoc
class _$CurrentUserCopyWithImpl<$Res>
    implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._self, this._then);

  final CurrentUser _self;
  final $Res Function(CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? loginType = null,Object? identifier = null,Object? username = null,Object? role = null,Object? businessType = freezed,Object? avatar = freezed,Object? bio = freezed,}) {
  return _then(CurrentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentUser].
extension CurrentUserPatterns on CurrentUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentUser value)  $default,){
final _that = this;
switch (_that) {
case _CurrentUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentUser value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LoginType loginType,  String identifier,  String username,  UserRole role,  BusinessType? businessType,  String? avatar,  String? bio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.loginType,_that.identifier,_that.username,_that.role,_that.businessType,_that.avatar,_that.bio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LoginType loginType,  String identifier,  String username,  UserRole role,  BusinessType? businessType,  String? avatar,  String? bio)  $default,) {final _that = this;
switch (_that) {
case _CurrentUser():
return $default(_that.id,_that.loginType,_that.identifier,_that.username,_that.role,_that.businessType,_that.avatar,_that.bio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LoginType loginType,  String identifier,  String username,  UserRole role,  BusinessType? businessType,  String? avatar,  String? bio)?  $default,) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.loginType,_that.identifier,_that.username,_that.role,_that.businessType,_that.avatar,_that.bio);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentUser implements CurrentUser {
  const _CurrentUser({required this.id, required this.loginType, required this.identifier, required this.username, required this.role, this.businessType, this.avatar, this.bio});
  

@override final  String id;
@override final  LoginType loginType;
/// Email or phone, per [loginType].
@override final  String identifier;
@override final  String username;
@override final  UserRole role;
@override final  BusinessType? businessType;
@override final  String? avatar;
@override final  String? bio;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentUserCopyWith<_CurrentUser> get copyWith => __$CurrentUserCopyWithImpl<_CurrentUser>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentUser&&(identical(other.id, id) || other.id == id)&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role)&&(identical(other.businessType, businessType) || other.businessType == businessType)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,loginType,identifier,username,role,businessType,avatar,bio);
}

@override
String toString() {
    return 'CurrentUser(id: $id, loginType: $loginType, identifier: $identifier, username: $username, role: $role, businessType: $businessType, avatar: $avatar, bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$CurrentUserCopyWith<$Res> implements $CurrentUserCopyWith<$Res> {
  factory _$CurrentUserCopyWith(_CurrentUser value, $Res Function(_CurrentUser) _then) = __$CurrentUserCopyWithImpl;
@override @useResult
$Res call({
 String id, LoginType loginType, String identifier, String username, UserRole role, BusinessType? businessType, String? avatar, String? bio
});




}
/// @nodoc
class __$CurrentUserCopyWithImpl<$Res>
    implements _$CurrentUserCopyWith<$Res> {
  __$CurrentUserCopyWithImpl(this._self, this._then);

  final _CurrentUser _self;
  final $Res Function(_CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? loginType = null,Object? identifier = null,Object? username = null,Object? role = null,Object? businessType = freezed,Object? avatar = freezed,Object? bio = freezed,}) {
  return _then(_CurrentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
