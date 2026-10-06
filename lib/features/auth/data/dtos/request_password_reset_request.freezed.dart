// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_password_reset_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestPasswordResetRequest {

 LoginType get loginType; String get identifier;
/// Create a copy of RequestPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestPasswordResetRequestCopyWith<RequestPasswordResetRequest> get copyWith => _$RequestPasswordResetRequestCopyWithImpl<RequestPasswordResetRequest>(this as RequestPasswordResetRequest, _$identity);

  /// Serializes this RequestPasswordResetRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RequestPasswordResetRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestPasswordResetRequest&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RequestPasswordResetRequest;
  return Object.hash(runtimeType,_this.loginType,_this.identifier);
}

@override
String toString() {
  final _this = this as RequestPasswordResetRequest;
  return 'RequestPasswordResetRequest(loginType: ${_this.loginType}, identifier: ${_this.identifier})';
}


}

/// @nodoc
abstract mixin class $RequestPasswordResetRequestCopyWith<$Res>  {
  factory $RequestPasswordResetRequestCopyWith(RequestPasswordResetRequest value, $Res Function(RequestPasswordResetRequest) _then) = _$RequestPasswordResetRequestCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class _$RequestPasswordResetRequestCopyWithImpl<$Res>
    implements $RequestPasswordResetRequestCopyWith<$Res> {
  _$RequestPasswordResetRequestCopyWithImpl(this._self, this._then);

  final RequestPasswordResetRequest _self;
  final $Res Function(RequestPasswordResetRequest) _then;

/// Create a copy of RequestPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(RequestPasswordResetRequest(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestPasswordResetRequest].
extension RequestPasswordResetRequestPatterns on RequestPasswordResetRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestPasswordResetRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestPasswordResetRequest value)  $default,){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestPasswordResetRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequest() when $default != null:
return $default(_that.loginType,_that.identifier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginType loginType,  String identifier)  $default,) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequest():
return $default(_that.loginType,_that.identifier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginType loginType,  String identifier)?  $default,) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequest() when $default != null:
return $default(_that.loginType,_that.identifier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestPasswordResetRequest implements RequestPasswordResetRequest {
  const _RequestPasswordResetRequest({required this.loginType, required this.identifier});
  factory _RequestPasswordResetRequest.fromJson(Map<String, dynamic> json) => _$RequestPasswordResetRequestFromJson(json);

@override final  LoginType loginType;
@override final  String identifier;

/// Create a copy of RequestPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestPasswordResetRequestCopyWith<_RequestPasswordResetRequest> get copyWith => __$RequestPasswordResetRequestCopyWithImpl<_RequestPasswordResetRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestPasswordResetRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestPasswordResetRequest&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier);
}

@override
String toString() {
    return 'RequestPasswordResetRequest(loginType: $loginType, identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class _$RequestPasswordResetRequestCopyWith<$Res> implements $RequestPasswordResetRequestCopyWith<$Res> {
  factory _$RequestPasswordResetRequestCopyWith(_RequestPasswordResetRequest value, $Res Function(_RequestPasswordResetRequest) _then) = __$RequestPasswordResetRequestCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class __$RequestPasswordResetRequestCopyWithImpl<$Res>
    implements _$RequestPasswordResetRequestCopyWith<$Res> {
  __$RequestPasswordResetRequestCopyWithImpl(this._self, this._then);

  final _RequestPasswordResetRequest _self;
  final $Res Function(_RequestPasswordResetRequest) _then;

/// Create a copy of RequestPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(_RequestPasswordResetRequest(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
