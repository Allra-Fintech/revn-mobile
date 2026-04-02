// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_auth_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialAuthRequestDto {

 String get accessToken;
/// Create a copy of SocialAuthRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialAuthRequestDtoCopyWith<SocialAuthRequestDto> get copyWith => _$SocialAuthRequestDtoCopyWithImpl<SocialAuthRequestDto>(this as SocialAuthRequestDto, _$identity);

  /// Serializes this SocialAuthRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAuthRequestDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'SocialAuthRequestDto(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class $SocialAuthRequestDtoCopyWith<$Res>  {
  factory $SocialAuthRequestDtoCopyWith(SocialAuthRequestDto value, $Res Function(SocialAuthRequestDto) _then) = _$SocialAuthRequestDtoCopyWithImpl;
@useResult
$Res call({
 String accessToken
});




}
/// @nodoc
class _$SocialAuthRequestDtoCopyWithImpl<$Res>
    implements $SocialAuthRequestDtoCopyWith<$Res> {
  _$SocialAuthRequestDtoCopyWithImpl(this._self, this._then);

  final SocialAuthRequestDto _self;
  final $Res Function(SocialAuthRequestDto) _then;

/// Create a copy of SocialAuthRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialAuthRequestDto].
extension SocialAuthRequestDtoPatterns on SocialAuthRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialAuthRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialAuthRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialAuthRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _SocialAuthRequestDto():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialAuthRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _SocialAuthRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialAuthRequestDto() when $default != null:
return $default(_that.accessToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken)  $default,) {final _that = this;
switch (_that) {
case _SocialAuthRequestDto():
return $default(_that.accessToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken)?  $default,) {final _that = this;
switch (_that) {
case _SocialAuthRequestDto() when $default != null:
return $default(_that.accessToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialAuthRequestDto implements SocialAuthRequestDto {
  const _SocialAuthRequestDto({required this.accessToken});
  factory _SocialAuthRequestDto.fromJson(Map<String, dynamic> json) => _$SocialAuthRequestDtoFromJson(json);

@override final  String accessToken;

/// Create a copy of SocialAuthRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthRequestDtoCopyWith<_SocialAuthRequestDto> get copyWith => __$SocialAuthRequestDtoCopyWithImpl<_SocialAuthRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialAuthRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthRequestDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'SocialAuthRequestDto(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthRequestDtoCopyWith<$Res> implements $SocialAuthRequestDtoCopyWith<$Res> {
  factory _$SocialAuthRequestDtoCopyWith(_SocialAuthRequestDto value, $Res Function(_SocialAuthRequestDto) _then) = __$SocialAuthRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String accessToken
});




}
/// @nodoc
class __$SocialAuthRequestDtoCopyWithImpl<$Res>
    implements _$SocialAuthRequestDtoCopyWith<$Res> {
  __$SocialAuthRequestDtoCopyWithImpl(this._self, this._then);

  final _SocialAuthRequestDto _self;
  final $Res Function(_SocialAuthRequestDto) _then;

/// Create a copy of SocialAuthRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,}) {
  return _then(_SocialAuthRequestDto(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
