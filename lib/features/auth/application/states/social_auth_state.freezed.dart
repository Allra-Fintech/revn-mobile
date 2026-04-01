// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialAuthState {

 AsyncValue<void> get socialSignIn; PendingSocialLink? get pendingLink;
/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialAuthStateCopyWith<SocialAuthState> get copyWith => _$SocialAuthStateCopyWithImpl<SocialAuthState>(this as SocialAuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAuthState&&(identical(other.socialSignIn, socialSignIn) || other.socialSignIn == socialSignIn)&&(identical(other.pendingLink, pendingLink) || other.pendingLink == pendingLink));
}


@override
int get hashCode => Object.hash(runtimeType,socialSignIn,pendingLink);

@override
String toString() {
  return 'SocialAuthState(socialSignIn: $socialSignIn, pendingLink: $pendingLink)';
}


}

/// @nodoc
abstract mixin class $SocialAuthStateCopyWith<$Res>  {
  factory $SocialAuthStateCopyWith(SocialAuthState value, $Res Function(SocialAuthState) _then) = _$SocialAuthStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<void> socialSignIn, PendingSocialLink? pendingLink
});


$PendingSocialLinkCopyWith<$Res>? get pendingLink;

}
/// @nodoc
class _$SocialAuthStateCopyWithImpl<$Res>
    implements $SocialAuthStateCopyWith<$Res> {
  _$SocialAuthStateCopyWithImpl(this._self, this._then);

  final SocialAuthState _self;
  final $Res Function(SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? socialSignIn = null,Object? pendingLink = freezed,}) {
  return _then(_self.copyWith(
socialSignIn: null == socialSignIn ? _self.socialSignIn : socialSignIn // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,pendingLink: freezed == pendingLink ? _self.pendingLink : pendingLink // ignore: cast_nullable_to_non_nullable
as PendingSocialLink?,
  ));
}
/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingSocialLinkCopyWith<$Res>? get pendingLink {
    if (_self.pendingLink == null) {
    return null;
  }

  return $PendingSocialLinkCopyWith<$Res>(_self.pendingLink!, (value) {
    return _then(_self.copyWith(pendingLink: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialAuthState].
extension SocialAuthStatePatterns on SocialAuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialAuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialAuthState value)  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialAuthState value)?  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<void> socialSignIn,  PendingSocialLink? pendingLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.socialSignIn,_that.pendingLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<void> socialSignIn,  PendingSocialLink? pendingLink)  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState():
return $default(_that.socialSignIn,_that.pendingLink);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<void> socialSignIn,  PendingSocialLink? pendingLink)?  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.socialSignIn,_that.pendingLink);case _:
  return null;

}
}

}

/// @nodoc


class _SocialAuthState implements SocialAuthState {
  const _SocialAuthState({this.socialSignIn = const AsyncData<void>(null), this.pendingLink});
  

@override@JsonKey() final  AsyncValue<void> socialSignIn;
@override final  PendingSocialLink? pendingLink;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthStateCopyWith<_SocialAuthState> get copyWith => __$SocialAuthStateCopyWithImpl<_SocialAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthState&&(identical(other.socialSignIn, socialSignIn) || other.socialSignIn == socialSignIn)&&(identical(other.pendingLink, pendingLink) || other.pendingLink == pendingLink));
}


@override
int get hashCode => Object.hash(runtimeType,socialSignIn,pendingLink);

@override
String toString() {
  return 'SocialAuthState(socialSignIn: $socialSignIn, pendingLink: $pendingLink)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthStateCopyWith<$Res> implements $SocialAuthStateCopyWith<$Res> {
  factory _$SocialAuthStateCopyWith(_SocialAuthState value, $Res Function(_SocialAuthState) _then) = __$SocialAuthStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<void> socialSignIn, PendingSocialLink? pendingLink
});


@override $PendingSocialLinkCopyWith<$Res>? get pendingLink;

}
/// @nodoc
class __$SocialAuthStateCopyWithImpl<$Res>
    implements _$SocialAuthStateCopyWith<$Res> {
  __$SocialAuthStateCopyWithImpl(this._self, this._then);

  final _SocialAuthState _self;
  final $Res Function(_SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? socialSignIn = null,Object? pendingLink = freezed,}) {
  return _then(_SocialAuthState(
socialSignIn: null == socialSignIn ? _self.socialSignIn : socialSignIn // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,pendingLink: freezed == pendingLink ? _self.pendingLink : pendingLink // ignore: cast_nullable_to_non_nullable
as PendingSocialLink?,
  ));
}

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingSocialLinkCopyWith<$Res>? get pendingLink {
    if (_self.pendingLink == null) {
    return null;
  }

  return $PendingSocialLinkCopyWith<$Res>(_self.pendingLink!, (value) {
    return _then(_self.copyWith(pendingLink: value));
  });
}
}

// dart format on
