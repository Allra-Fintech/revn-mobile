// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_social_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingSocialLink {

 SocialProvider get provider; String get accessToken; SocialLinkStatus get linkStatus; String? get lastErrorMessage;
/// Create a copy of PendingSocialLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingSocialLinkCopyWith<PendingSocialLink> get copyWith => _$PendingSocialLinkCopyWithImpl<PendingSocialLink>(this as PendingSocialLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingSocialLink&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.linkStatus, linkStatus) || other.linkStatus == linkStatus)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,provider,accessToken,linkStatus,lastErrorMessage);



}

/// @nodoc
abstract mixin class $PendingSocialLinkCopyWith<$Res>  {
  factory $PendingSocialLinkCopyWith(PendingSocialLink value, $Res Function(PendingSocialLink) _then) = _$PendingSocialLinkCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider, String accessToken, SocialLinkStatus linkStatus, String? lastErrorMessage
});




}
/// @nodoc
class _$PendingSocialLinkCopyWithImpl<$Res>
    implements $PendingSocialLinkCopyWith<$Res> {
  _$PendingSocialLinkCopyWithImpl(this._self, this._then);

  final PendingSocialLink _self;
  final $Res Function(PendingSocialLink) _then;

/// Create a copy of PendingSocialLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? accessToken = null,Object? linkStatus = null,Object? lastErrorMessage = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,linkStatus: null == linkStatus ? _self.linkStatus : linkStatus // ignore: cast_nullable_to_non_nullable
as SocialLinkStatus,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingSocialLink].
extension PendingSocialLinkPatterns on PendingSocialLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingSocialLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingSocialLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingSocialLink value)  $default,){
final _that = this;
switch (_that) {
case _PendingSocialLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingSocialLink value)?  $default,){
final _that = this;
switch (_that) {
case _PendingSocialLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SocialProvider provider,  String accessToken,  SocialLinkStatus linkStatus,  String? lastErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingSocialLink() when $default != null:
return $default(_that.provider,_that.accessToken,_that.linkStatus,_that.lastErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SocialProvider provider,  String accessToken,  SocialLinkStatus linkStatus,  String? lastErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _PendingSocialLink():
return $default(_that.provider,_that.accessToken,_that.linkStatus,_that.lastErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SocialProvider provider,  String accessToken,  SocialLinkStatus linkStatus,  String? lastErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PendingSocialLink() when $default != null:
return $default(_that.provider,_that.accessToken,_that.linkStatus,_that.lastErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PendingSocialLink extends PendingSocialLink {
  const _PendingSocialLink({required this.provider, required this.accessToken, this.linkStatus = SocialLinkStatus.pending, this.lastErrorMessage}): super._();
  

@override final  SocialProvider provider;
@override final  String accessToken;
@override@JsonKey() final  SocialLinkStatus linkStatus;
@override final  String? lastErrorMessage;

/// Create a copy of PendingSocialLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingSocialLinkCopyWith<_PendingSocialLink> get copyWith => __$PendingSocialLinkCopyWithImpl<_PendingSocialLink>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingSocialLink&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.linkStatus, linkStatus) || other.linkStatus == linkStatus)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,provider,accessToken,linkStatus,lastErrorMessage);



}

/// @nodoc
abstract mixin class _$PendingSocialLinkCopyWith<$Res> implements $PendingSocialLinkCopyWith<$Res> {
  factory _$PendingSocialLinkCopyWith(_PendingSocialLink value, $Res Function(_PendingSocialLink) _then) = __$PendingSocialLinkCopyWithImpl;
@override @useResult
$Res call({
 SocialProvider provider, String accessToken, SocialLinkStatus linkStatus, String? lastErrorMessage
});




}
/// @nodoc
class __$PendingSocialLinkCopyWithImpl<$Res>
    implements _$PendingSocialLinkCopyWith<$Res> {
  __$PendingSocialLinkCopyWithImpl(this._self, this._then);

  final _PendingSocialLink _self;
  final $Res Function(_PendingSocialLink) _then;

/// Create a copy of PendingSocialLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? accessToken = null,Object? linkStatus = null,Object? lastErrorMessage = freezed,}) {
  return _then(_PendingSocialLink(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,linkStatus: null == linkStatus ? _self.linkStatus : linkStatus // ignore: cast_nullable_to_non_nullable
as SocialLinkStatus,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
