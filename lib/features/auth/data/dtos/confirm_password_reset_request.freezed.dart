// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_password_reset_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfirmPasswordResetRequest {

 String get identifier; String get code; String get newPassword;
/// Create a copy of ConfirmPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmPasswordResetRequestCopyWith<ConfirmPasswordResetRequest> get copyWith => _$ConfirmPasswordResetRequestCopyWithImpl<ConfirmPasswordResetRequest>(this as ConfirmPasswordResetRequest, _$identity);

  /// Serializes this ConfirmPasswordResetRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConfirmPasswordResetRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmPasswordResetRequest&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.newPassword, _this.newPassword) || other.newPassword == _this.newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConfirmPasswordResetRequest;
  return Object.hash(runtimeType,_this.identifier,_this.code,_this.newPassword);
}

@override
String toString() {
  final _this = this as ConfirmPasswordResetRequest;
  return 'ConfirmPasswordResetRequest(identifier: ${_this.identifier}, code: ${_this.code}, newPassword: ${_this.newPassword})';
}


}

/// @nodoc
abstract mixin class $ConfirmPasswordResetRequestCopyWith<$Res>  {
  factory $ConfirmPasswordResetRequestCopyWith(ConfirmPasswordResetRequest value, $Res Function(ConfirmPasswordResetRequest) _then) = _$ConfirmPasswordResetRequestCopyWithImpl;
@useResult
$Res call({
 String identifier, String code, String newPassword
});




}
/// @nodoc
class _$ConfirmPasswordResetRequestCopyWithImpl<$Res>
    implements $ConfirmPasswordResetRequestCopyWith<$Res> {
  _$ConfirmPasswordResetRequestCopyWithImpl(this._self, this._then);

  final ConfirmPasswordResetRequest _self;
  final $Res Function(ConfirmPasswordResetRequest) _then;

/// Create a copy of ConfirmPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? code = null,Object? newPassword = null,}) {
  return _then(ConfirmPasswordResetRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmPasswordResetRequest].
extension ConfirmPasswordResetRequestPatterns on ConfirmPasswordResetRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmPasswordResetRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmPasswordResetRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmPasswordResetRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String code,  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest() when $default != null:
return $default(_that.identifier,_that.code,_that.newPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String code,  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest():
return $default(_that.identifier,_that.code,_that.newPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String code,  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmPasswordResetRequest() when $default != null:
return $default(_that.identifier,_that.code,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmPasswordResetRequest implements ConfirmPasswordResetRequest {
  const _ConfirmPasswordResetRequest({required this.identifier, required this.code, required this.newPassword});
  factory _ConfirmPasswordResetRequest.fromJson(Map<String, dynamic> json) => _$ConfirmPasswordResetRequestFromJson(json);

@override final  String identifier;
@override final  String code;
@override final  String newPassword;

/// Create a copy of ConfirmPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPasswordResetRequestCopyWith<_ConfirmPasswordResetRequest> get copyWith => __$ConfirmPasswordResetRequestCopyWithImpl<_ConfirmPasswordResetRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmPasswordResetRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordResetRequest&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.code, code) || other.code == code)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,identifier,code,newPassword);
}

@override
String toString() {
    return 'ConfirmPasswordResetRequest(identifier: $identifier, code: $code, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPasswordResetRequestCopyWith<$Res> implements $ConfirmPasswordResetRequestCopyWith<$Res> {
  factory _$ConfirmPasswordResetRequestCopyWith(_ConfirmPasswordResetRequest value, $Res Function(_ConfirmPasswordResetRequest) _then) = __$ConfirmPasswordResetRequestCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String code, String newPassword
});




}
/// @nodoc
class __$ConfirmPasswordResetRequestCopyWithImpl<$Res>
    implements _$ConfirmPasswordResetRequestCopyWith<$Res> {
  __$ConfirmPasswordResetRequestCopyWithImpl(this._self, this._then);

  final _ConfirmPasswordResetRequest _self;
  final $Res Function(_ConfirmPasswordResetRequest) _then;

/// Create a copy of ConfirmPasswordResetRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? code = null,Object? newPassword = null,}) {
  return _then(_ConfirmPasswordResetRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
