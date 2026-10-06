// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resend_code_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResendCodeRequest {

 String get identifier; OtpPurpose get purpose;
/// Create a copy of ResendCodeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResendCodeRequestCopyWith<ResendCodeRequest> get copyWith => _$ResendCodeRequestCopyWithImpl<ResendCodeRequest>(this as ResendCodeRequest, _$identity);

  /// Serializes this ResendCodeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ResendCodeRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResendCodeRequest&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.purpose, _this.purpose) || other.purpose == _this.purpose));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ResendCodeRequest;
  return Object.hash(runtimeType,_this.identifier,_this.purpose);
}

@override
String toString() {
  final _this = this as ResendCodeRequest;
  return 'ResendCodeRequest(identifier: ${_this.identifier}, purpose: ${_this.purpose})';
}


}

/// @nodoc
abstract mixin class $ResendCodeRequestCopyWith<$Res>  {
  factory $ResendCodeRequestCopyWith(ResendCodeRequest value, $Res Function(ResendCodeRequest) _then) = _$ResendCodeRequestCopyWithImpl;
@useResult
$Res call({
 String identifier, OtpPurpose purpose
});




}
/// @nodoc
class _$ResendCodeRequestCopyWithImpl<$Res>
    implements $ResendCodeRequestCopyWith<$Res> {
  _$ResendCodeRequestCopyWithImpl(this._self, this._then);

  final ResendCodeRequest _self;
  final $Res Function(ResendCodeRequest) _then;

/// Create a copy of ResendCodeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? purpose = null,}) {
  return _then(ResendCodeRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as OtpPurpose,
  ));
}

}


/// Adds pattern-matching-related methods to [ResendCodeRequest].
extension ResendCodeRequestPatterns on ResendCodeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResendCodeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResendCodeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResendCodeRequest value)  $default,){
final _that = this;
switch (_that) {
case _ResendCodeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResendCodeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ResendCodeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  OtpPurpose purpose)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResendCodeRequest() when $default != null:
return $default(_that.identifier,_that.purpose);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  OtpPurpose purpose)  $default,) {final _that = this;
switch (_that) {
case _ResendCodeRequest():
return $default(_that.identifier,_that.purpose);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  OtpPurpose purpose)?  $default,) {final _that = this;
switch (_that) {
case _ResendCodeRequest() when $default != null:
return $default(_that.identifier,_that.purpose);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResendCodeRequest implements ResendCodeRequest {
  const _ResendCodeRequest({required this.identifier, required this.purpose});
  factory _ResendCodeRequest.fromJson(Map<String, dynamic> json) => _$ResendCodeRequestFromJson(json);

@override final  String identifier;
@override final  OtpPurpose purpose;

/// Create a copy of ResendCodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendCodeRequestCopyWith<_ResendCodeRequest> get copyWith => __$ResendCodeRequestCopyWithImpl<_ResendCodeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResendCodeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendCodeRequest&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.purpose, purpose) || other.purpose == purpose));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,identifier,purpose);
}

@override
String toString() {
    return 'ResendCodeRequest(identifier: $identifier, purpose: $purpose)';
}


}

/// @nodoc
abstract mixin class _$ResendCodeRequestCopyWith<$Res> implements $ResendCodeRequestCopyWith<$Res> {
  factory _$ResendCodeRequestCopyWith(_ResendCodeRequest value, $Res Function(_ResendCodeRequest) _then) = __$ResendCodeRequestCopyWithImpl;
@override @useResult
$Res call({
 String identifier, OtpPurpose purpose
});




}
/// @nodoc
class __$ResendCodeRequestCopyWithImpl<$Res>
    implements _$ResendCodeRequestCopyWith<$Res> {
  __$ResendCodeRequestCopyWithImpl(this._self, this._then);

  final _ResendCodeRequest _self;
  final $Res Function(_ResendCodeRequest) _then;

/// Create a copy of ResendCodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? purpose = null,}) {
  return _then(_ResendCodeRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as OtpPurpose,
  ));
}


}

// dart format on
