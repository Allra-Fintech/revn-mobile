// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInControllerState {

 AsyncValue<void> get submission; CurrentUser? get signedInUser;
/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInControllerStateCopyWith<SignInControllerState> get copyWith => _$SignInControllerStateCopyWithImpl<SignInControllerState>(this as SignInControllerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInControllerState&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.signedInUser, signedInUser) || other.signedInUser == signedInUser));
}


@override
int get hashCode => Object.hash(runtimeType,submission,signedInUser);

@override
String toString() {
  return 'SignInControllerState(submission: $submission, signedInUser: $signedInUser)';
}


}

/// @nodoc
abstract mixin class $SignInControllerStateCopyWith<$Res>  {
  factory $SignInControllerStateCopyWith(SignInControllerState value, $Res Function(SignInControllerState) _then) = _$SignInControllerStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<void> submission, CurrentUser? signedInUser
});


$CurrentUserCopyWith<$Res>? get signedInUser;

}
/// @nodoc
class _$SignInControllerStateCopyWithImpl<$Res>
    implements $SignInControllerStateCopyWith<$Res> {
  _$SignInControllerStateCopyWithImpl(this._self, this._then);

  final SignInControllerState _self;
  final $Res Function(SignInControllerState) _then;

/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submission = null,Object? signedInUser = freezed,}) {
  return _then(_self.copyWith(
submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,signedInUser: freezed == signedInUser ? _self.signedInUser : signedInUser // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}
/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<$Res>? get signedInUser {
    if (_self.signedInUser == null) {
    return null;
  }

  return $CurrentUserCopyWith<$Res>(_self.signedInUser!, (value) {
    return _then(_self.copyWith(signedInUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInControllerState].
extension SignInControllerStatePatterns on SignInControllerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInControllerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInControllerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInControllerState value)  $default,){
final _that = this;
switch (_that) {
case _SignInControllerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInControllerState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInControllerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<void> submission,  CurrentUser? signedInUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInControllerState() when $default != null:
return $default(_that.submission,_that.signedInUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<void> submission,  CurrentUser? signedInUser)  $default,) {final _that = this;
switch (_that) {
case _SignInControllerState():
return $default(_that.submission,_that.signedInUser);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<void> submission,  CurrentUser? signedInUser)?  $default,) {final _that = this;
switch (_that) {
case _SignInControllerState() when $default != null:
return $default(_that.submission,_that.signedInUser);case _:
  return null;

}
}

}

/// @nodoc


class _SignInControllerState implements SignInControllerState {
  const _SignInControllerState({this.submission = const AsyncData<void>(null), this.signedInUser});
  

@override@JsonKey() final  AsyncValue<void> submission;
@override final  CurrentUser? signedInUser;

/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInControllerStateCopyWith<_SignInControllerState> get copyWith => __$SignInControllerStateCopyWithImpl<_SignInControllerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInControllerState&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.signedInUser, signedInUser) || other.signedInUser == signedInUser));
}


@override
int get hashCode => Object.hash(runtimeType,submission,signedInUser);

@override
String toString() {
  return 'SignInControllerState(submission: $submission, signedInUser: $signedInUser)';
}


}

/// @nodoc
abstract mixin class _$SignInControllerStateCopyWith<$Res> implements $SignInControllerStateCopyWith<$Res> {
  factory _$SignInControllerStateCopyWith(_SignInControllerState value, $Res Function(_SignInControllerState) _then) = __$SignInControllerStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<void> submission, CurrentUser? signedInUser
});


@override $CurrentUserCopyWith<$Res>? get signedInUser;

}
/// @nodoc
class __$SignInControllerStateCopyWithImpl<$Res>
    implements _$SignInControllerStateCopyWith<$Res> {
  __$SignInControllerStateCopyWithImpl(this._self, this._then);

  final _SignInControllerState _self;
  final $Res Function(_SignInControllerState) _then;

/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submission = null,Object? signedInUser = freezed,}) {
  return _then(_SignInControllerState(
submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,signedInUser: freezed == signedInUser ? _self.signedInUser : signedInUser // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}

/// Create a copy of SignInControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<$Res>? get signedInUser {
    if (_self.signedInUser == null) {
    return null;
  }

  return $CurrentUserCopyWith<$Res>(_self.signedInUser!, (value) {
    return _then(_self.copyWith(signedInUser: value));
  });
}
}

// dart format on
