// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_handoff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginHandoff {

 LoginType get loginType; String get identifier;
/// Create a copy of LoginHandoff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginHandoffCopyWith<LoginHandoff> get copyWith => _$LoginHandoffCopyWithImpl<LoginHandoff>(this as LoginHandoff, _$identity);

  /// Serializes this LoginHandoff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LoginHandoff;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginHandoff&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LoginHandoff;
  return Object.hash(runtimeType,_this.loginType,_this.identifier);
}

@override
String toString() {
  final _this = this as LoginHandoff;
  return 'LoginHandoff(loginType: ${_this.loginType}, identifier: ${_this.identifier})';
}


}

/// @nodoc
abstract mixin class $LoginHandoffCopyWith<$Res>  {
  factory $LoginHandoffCopyWith(LoginHandoff value, $Res Function(LoginHandoff) _then) = _$LoginHandoffCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class _$LoginHandoffCopyWithImpl<$Res>
    implements $LoginHandoffCopyWith<$Res> {
  _$LoginHandoffCopyWithImpl(this._self, this._then);

  final LoginHandoff _self;
  final $Res Function(LoginHandoff) _then;

/// Create a copy of LoginHandoff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(LoginHandoff(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginHandoff].
extension LoginHandoffPatterns on LoginHandoff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginHandoff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginHandoff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginHandoff value)  $default,){
final _that = this;
switch (_that) {
case _LoginHandoff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginHandoff value)?  $default,){
final _that = this;
switch (_that) {
case _LoginHandoff() when $default != null:
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
case _LoginHandoff() when $default != null:
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
case _LoginHandoff():
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
case _LoginHandoff() when $default != null:
return $default(_that.loginType,_that.identifier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginHandoff implements LoginHandoff {
  const _LoginHandoff({required this.loginType, required this.identifier});
  factory _LoginHandoff.fromJson(Map<String, dynamic> json) => _$LoginHandoffFromJson(json);

@override final  LoginType loginType;
@override final  String identifier;

/// Create a copy of LoginHandoff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginHandoffCopyWith<_LoginHandoff> get copyWith => __$LoginHandoffCopyWithImpl<_LoginHandoff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginHandoffToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginHandoff&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier);
}

@override
String toString() {
    return 'LoginHandoff(loginType: $loginType, identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class _$LoginHandoffCopyWith<$Res> implements $LoginHandoffCopyWith<$Res> {
  factory _$LoginHandoffCopyWith(_LoginHandoff value, $Res Function(_LoginHandoff) _then) = __$LoginHandoffCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class __$LoginHandoffCopyWithImpl<$Res>
    implements _$LoginHandoffCopyWith<$Res> {
  __$LoginHandoffCopyWithImpl(this._self, this._then);

  final _LoginHandoff _self;
  final $Res Function(_LoginHandoff) _then;

/// Create a copy of LoginHandoff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(_LoginHandoff(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
