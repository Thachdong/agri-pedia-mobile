// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_handoff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthHandoff {

 LoginType get loginType; String get identifier; DateTime get at; OtpPurpose get purpose;
/// Create a copy of AuthHandoff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthHandoffCopyWith<AuthHandoff> get copyWith => _$AuthHandoffCopyWithImpl<AuthHandoff>(this as AuthHandoff, _$identity);

  /// Serializes this AuthHandoff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthHandoff;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthHandoff&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.purpose, _this.purpose) || other.purpose == _this.purpose));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthHandoff;
  return Object.hash(runtimeType,_this.loginType,_this.identifier,_this.at,_this.purpose);
}

@override
String toString() {
  final _this = this as AuthHandoff;
  return 'AuthHandoff(loginType: ${_this.loginType}, identifier: ${_this.identifier}, at: ${_this.at}, purpose: ${_this.purpose})';
}


}

/// @nodoc
abstract mixin class $AuthHandoffCopyWith<$Res>  {
  factory $AuthHandoffCopyWith(AuthHandoff value, $Res Function(AuthHandoff) _then) = _$AuthHandoffCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier, DateTime at, OtpPurpose purpose
});




}
/// @nodoc
class _$AuthHandoffCopyWithImpl<$Res>
    implements $AuthHandoffCopyWith<$Res> {
  _$AuthHandoffCopyWithImpl(this._self, this._then);

  final AuthHandoff _self;
  final $Res Function(AuthHandoff) _then;

/// Create a copy of AuthHandoff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,Object? at = null,Object? purpose = null,}) {
  return _then(AuthHandoff(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as OtpPurpose,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthHandoff].
extension AuthHandoffPatterns on AuthHandoff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthHandoff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthHandoff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthHandoff value)  $default,){
final _that = this;
switch (_that) {
case _AuthHandoff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthHandoff value)?  $default,){
final _that = this;
switch (_that) {
case _AuthHandoff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  DateTime at,  OtpPurpose purpose)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthHandoff() when $default != null:
return $default(_that.loginType,_that.identifier,_that.at,_that.purpose);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier,  DateTime at,  OtpPurpose purpose)  $default,) {final _that = this;
switch (_that) {
case _AuthHandoff():
return $default(_that.loginType,_that.identifier,_that.at,_that.purpose);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier,  DateTime at,  OtpPurpose purpose)?  $default,) {final _that = this;
switch (_that) {
case _AuthHandoff() when $default != null:
return $default(_that.loginType,_that.identifier,_that.at,_that.purpose);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthHandoff implements AuthHandoff {
  const _AuthHandoff({required this.loginType, required this.identifier, required this.at, required this.purpose});
  factory _AuthHandoff.fromJson(Map<String, dynamic> json) => _$AuthHandoffFromJson(json);

@override final  LoginType loginType;
@override final  String identifier;
@override final  DateTime at;
@override final  OtpPurpose purpose;

/// Create a copy of AuthHandoff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthHandoffCopyWith<_AuthHandoff> get copyWith => __$AuthHandoffCopyWithImpl<_AuthHandoff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthHandoffToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthHandoff&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.at, at) || other.at == at)&&(identical(other.purpose, purpose) || other.purpose == purpose));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier,at,purpose);
}

@override
String toString() {
    return 'AuthHandoff(loginType: $loginType, identifier: $identifier, at: $at, purpose: $purpose)';
}


}

/// @nodoc
abstract mixin class _$AuthHandoffCopyWith<$Res> implements $AuthHandoffCopyWith<$Res> {
  factory _$AuthHandoffCopyWith(_AuthHandoff value, $Res Function(_AuthHandoff) _then) = __$AuthHandoffCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier, DateTime at, OtpPurpose purpose
});




}
/// @nodoc
class __$AuthHandoffCopyWithImpl<$Res>
    implements _$AuthHandoffCopyWith<$Res> {
  __$AuthHandoffCopyWithImpl(this._self, this._then);

  final _AuthHandoff _self;
  final $Res Function(_AuthHandoff) _then;

/// Create a copy of AuthHandoff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,Object? at = null,Object? purpose = null,}) {
  return _then(_AuthHandoff(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as OtpPurpose,
  ));
}


}

// dart format on
