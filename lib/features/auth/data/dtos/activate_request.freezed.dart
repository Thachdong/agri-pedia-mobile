// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activate_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivateRequest {

 String get identifier; String get code;
/// Create a copy of ActivateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivateRequestCopyWith<ActivateRequest> get copyWith => _$ActivateRequestCopyWithImpl<ActivateRequest>(this as ActivateRequest, _$identity);

  /// Serializes this ActivateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivateRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivateRequest&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.code, _this.code) || other.code == _this.code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivateRequest;
  return Object.hash(runtimeType,_this.identifier,_this.code);
}

@override
String toString() {
  final _this = this as ActivateRequest;
  return 'ActivateRequest(identifier: ${_this.identifier}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $ActivateRequestCopyWith<$Res>  {
  factory $ActivateRequestCopyWith(ActivateRequest value, $Res Function(ActivateRequest) _then) = _$ActivateRequestCopyWithImpl;
@useResult
$Res call({
 String identifier, String code
});




}
/// @nodoc
class _$ActivateRequestCopyWithImpl<$Res>
    implements $ActivateRequestCopyWith<$Res> {
  _$ActivateRequestCopyWithImpl(this._self, this._then);

  final ActivateRequest _self;
  final $Res Function(ActivateRequest) _then;

/// Create a copy of ActivateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? code = null,}) {
  return _then(ActivateRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivateRequest].
extension ActivateRequestPatterns on ActivateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivateRequest value)  $default,){
final _that = this;
switch (_that) {
case _ActivateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ActivateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivateRequest() when $default != null:
return $default(_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String code)  $default,) {final _that = this;
switch (_that) {
case _ActivateRequest():
return $default(_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String code)?  $default,) {final _that = this;
switch (_that) {
case _ActivateRequest() when $default != null:
return $default(_that.identifier,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivateRequest implements ActivateRequest {
  const _ActivateRequest({required this.identifier, required this.code});
  factory _ActivateRequest.fromJson(Map<String, dynamic> json) => _$ActivateRequestFromJson(json);

@override final  String identifier;
@override final  String code;

/// Create a copy of ActivateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivateRequestCopyWith<_ActivateRequest> get copyWith => __$ActivateRequestCopyWithImpl<_ActivateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivateRequest&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,identifier,code);
}

@override
String toString() {
    return 'ActivateRequest(identifier: $identifier, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ActivateRequestCopyWith<$Res> implements $ActivateRequestCopyWith<$Res> {
  factory _$ActivateRequestCopyWith(_ActivateRequest value, $Res Function(_ActivateRequest) _then) = __$ActivateRequestCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String code
});




}
/// @nodoc
class __$ActivateRequestCopyWithImpl<$Res>
    implements _$ActivateRequestCopyWith<$Res> {
  __$ActivateRequestCopyWithImpl(this._self, this._then);

  final _ActivateRequest _self;
  final $Res Function(_ActivateRequest) _then;

/// Create a copy of ActivateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? code = null,}) {
  return _then(_ActivateRequest(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
