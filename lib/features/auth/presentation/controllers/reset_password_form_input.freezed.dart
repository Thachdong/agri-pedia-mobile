// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_form_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordFormInput {

 LoginType get loginType; String get identifier;
/// Create a copy of ResetPasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordFormInputCopyWith<ResetPasswordFormInput> get copyWith => _$ResetPasswordFormInputCopyWithImpl<ResetPasswordFormInput>(this as ResetPasswordFormInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResetPasswordFormInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordFormInput&&(identical(other.loginType, _this.loginType) || other.loginType == _this.loginType)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier));
}


@override
int get hashCode {
  final _this = this as ResetPasswordFormInput;
  return Object.hash(runtimeType,_this.loginType,_this.identifier);
}

@override
String toString() {
  final _this = this as ResetPasswordFormInput;
  return 'ResetPasswordFormInput(loginType: ${_this.loginType}, identifier: ${_this.identifier})';
}


}

/// @nodoc
abstract mixin class $ResetPasswordFormInputCopyWith<$Res>  {
  factory $ResetPasswordFormInputCopyWith(ResetPasswordFormInput value, $Res Function(ResetPasswordFormInput) _then) = _$ResetPasswordFormInputCopyWithImpl;
@useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class _$ResetPasswordFormInputCopyWithImpl<$Res>
    implements $ResetPasswordFormInputCopyWith<$Res> {
  _$ResetPasswordFormInputCopyWithImpl(this._self, this._then);

  final ResetPasswordFormInput _self;
  final $Res Function(ResetPasswordFormInput) _then;

/// Create a copy of ResetPasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(ResetPasswordFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordFormInput].
extension ResetPasswordFormInputPatterns on ResetPasswordFormInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordFormInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordFormInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordFormInput value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordFormInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordFormInput value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordFormInput() when $default != null:
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
case _ResetPasswordFormInput() when $default != null:
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
case _ResetPasswordFormInput():
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
case _ResetPasswordFormInput() when $default != null:
return $default(_that.loginType,_that.identifier);case _:
  return null;

}
}

}

/// @nodoc


class _ResetPasswordFormInput extends ResetPasswordFormInput {
  const _ResetPasswordFormInput({required this.loginType, required this.identifier}): super._();
  

@override final  LoginType loginType;
@override final  String identifier;

/// Create a copy of ResetPasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordFormInputCopyWith<_ResetPasswordFormInput> get copyWith => __$ResetPasswordFormInputCopyWithImpl<_ResetPasswordFormInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordFormInput&&(identical(other.loginType, loginType) || other.loginType == loginType)&&(identical(other.identifier, identifier) || other.identifier == identifier));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loginType,identifier);
}

@override
String toString() {
    return 'ResetPasswordFormInput(loginType: $loginType, identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordFormInputCopyWith<$Res> implements $ResetPasswordFormInputCopyWith<$Res> {
  factory _$ResetPasswordFormInputCopyWith(_ResetPasswordFormInput value, $Res Function(_ResetPasswordFormInput) _then) = __$ResetPasswordFormInputCopyWithImpl;
@override @useResult
$Res call({
 LoginType loginType, String identifier
});




}
/// @nodoc
class __$ResetPasswordFormInputCopyWithImpl<$Res>
    implements _$ResetPasswordFormInputCopyWith<$Res> {
  __$ResetPasswordFormInputCopyWithImpl(this._self, this._then);

  final _ResetPasswordFormInput _self;
  final $Res Function(_ResetPasswordFormInput) _then;

/// Create a copy of ResetPasswordFormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginType = null,Object? identifier = null,}) {
  return _then(_ResetPasswordFormInput(
loginType: null == loginType ? _self.loginType : loginType // ignore: cast_nullable_to_non_nullable
as LoginType,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
