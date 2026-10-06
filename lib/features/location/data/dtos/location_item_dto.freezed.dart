// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationItemDto {

 String get codename; String get name;
/// Create a copy of LocationItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationItemDtoCopyWith<LocationItemDto> get copyWith => _$LocationItemDtoCopyWithImpl<LocationItemDto>(this as LocationItemDto, _$identity);

  /// Serializes this LocationItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LocationItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationItemDto&&(identical(other.codename, _this.codename) || other.codename == _this.codename)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LocationItemDto;
  return Object.hash(runtimeType,_this.codename,_this.name);
}

@override
String toString() {
  final _this = this as LocationItemDto;
  return 'LocationItemDto(codename: ${_this.codename}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $LocationItemDtoCopyWith<$Res>  {
  factory $LocationItemDtoCopyWith(LocationItemDto value, $Res Function(LocationItemDto) _then) = _$LocationItemDtoCopyWithImpl;
@useResult
$Res call({
 String codename, String name
});




}
/// @nodoc
class _$LocationItemDtoCopyWithImpl<$Res>
    implements $LocationItemDtoCopyWith<$Res> {
  _$LocationItemDtoCopyWithImpl(this._self, this._then);

  final LocationItemDto _self;
  final $Res Function(LocationItemDto) _then;

/// Create a copy of LocationItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codename = null,Object? name = null,}) {
  return _then(LocationItemDto(
codename: null == codename ? _self.codename : codename // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationItemDto].
extension LocationItemDtoPatterns on LocationItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationItemDto value)  $default,){
final _that = this;
switch (_that) {
case _LocationItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _LocationItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String codename,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationItemDto() when $default != null:
return $default(_that.codename,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String codename,  String name)  $default,) {final _that = this;
switch (_that) {
case _LocationItemDto():
return $default(_that.codename,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String codename,  String name)?  $default,) {final _that = this;
switch (_that) {
case _LocationItemDto() when $default != null:
return $default(_that.codename,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationItemDto implements LocationItemDto {
  const _LocationItemDto({required this.codename, required this.name});
  factory _LocationItemDto.fromJson(Map<String, dynamic> json) => _$LocationItemDtoFromJson(json);

@override final  String codename;
@override final  String name;

/// Create a copy of LocationItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationItemDtoCopyWith<_LocationItemDto> get copyWith => __$LocationItemDtoCopyWithImpl<_LocationItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationItemDto&&(identical(other.codename, codename) || other.codename == codename)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,codename,name);
}

@override
String toString() {
    return 'LocationItemDto(codename: $codename, name: $name)';
}


}

/// @nodoc
abstract mixin class _$LocationItemDtoCopyWith<$Res> implements $LocationItemDtoCopyWith<$Res> {
  factory _$LocationItemDtoCopyWith(_LocationItemDto value, $Res Function(_LocationItemDto) _then) = __$LocationItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String codename, String name
});




}
/// @nodoc
class __$LocationItemDtoCopyWithImpl<$Res>
    implements _$LocationItemDtoCopyWith<$Res> {
  __$LocationItemDtoCopyWithImpl(this._self, this._then);

  final _LocationItemDto _self;
  final $Res Function(_LocationItemDto) _then;

/// Create a copy of LocationItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codename = null,Object? name = null,}) {
  return _then(_LocationItemDto(
codename: null == codename ? _self.codename : codename // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
