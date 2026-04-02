// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpControllerState {

 AsyncValue<void> get verification; AsyncValue<void> get submission; CurrentUser? get signedUpUser;
/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpControllerStateCopyWith<SignUpControllerState> get copyWith => _$SignUpControllerStateCopyWithImpl<SignUpControllerState>(this as SignUpControllerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpControllerState&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.signedUpUser, signedUpUser) || other.signedUpUser == signedUpUser));
}


@override
int get hashCode => Object.hash(runtimeType,verification,submission,signedUpUser);

@override
String toString() {
  return 'SignUpControllerState(verification: $verification, submission: $submission, signedUpUser: $signedUpUser)';
}


}

/// @nodoc
abstract mixin class $SignUpControllerStateCopyWith<$Res>  {
  factory $SignUpControllerStateCopyWith(SignUpControllerState value, $Res Function(SignUpControllerState) _then) = _$SignUpControllerStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<void> verification, AsyncValue<void> submission, CurrentUser? signedUpUser
});


$CurrentUserCopyWith<$Res>? get signedUpUser;

}
/// @nodoc
class _$SignUpControllerStateCopyWithImpl<$Res>
    implements $SignUpControllerStateCopyWith<$Res> {
  _$SignUpControllerStateCopyWithImpl(this._self, this._then);

  final SignUpControllerState _self;
  final $Res Function(SignUpControllerState) _then;

/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verification = null,Object? submission = null,Object? signedUpUser = freezed,}) {
  return _then(_self.copyWith(
verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,signedUpUser: freezed == signedUpUser ? _self.signedUpUser : signedUpUser // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}
/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<$Res>? get signedUpUser {
    if (_self.signedUpUser == null) {
    return null;
  }

  return $CurrentUserCopyWith<$Res>(_self.signedUpUser!, (value) {
    return _then(_self.copyWith(signedUpUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignUpControllerState].
extension SignUpControllerStatePatterns on SignUpControllerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpControllerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpControllerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpControllerState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpControllerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpControllerState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpControllerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<void> verification,  AsyncValue<void> submission,  CurrentUser? signedUpUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpControllerState() when $default != null:
return $default(_that.verification,_that.submission,_that.signedUpUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<void> verification,  AsyncValue<void> submission,  CurrentUser? signedUpUser)  $default,) {final _that = this;
switch (_that) {
case _SignUpControllerState():
return $default(_that.verification,_that.submission,_that.signedUpUser);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<void> verification,  AsyncValue<void> submission,  CurrentUser? signedUpUser)?  $default,) {final _that = this;
switch (_that) {
case _SignUpControllerState() when $default != null:
return $default(_that.verification,_that.submission,_that.signedUpUser);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpControllerState implements SignUpControllerState {
  const _SignUpControllerState({this.verification = const AsyncData<void>(null), this.submission = const AsyncData<void>(null), this.signedUpUser});
  

@override@JsonKey() final  AsyncValue<void> verification;
@override@JsonKey() final  AsyncValue<void> submission;
@override final  CurrentUser? signedUpUser;

/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpControllerStateCopyWith<_SignUpControllerState> get copyWith => __$SignUpControllerStateCopyWithImpl<_SignUpControllerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpControllerState&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.signedUpUser, signedUpUser) || other.signedUpUser == signedUpUser));
}


@override
int get hashCode => Object.hash(runtimeType,verification,submission,signedUpUser);

@override
String toString() {
  return 'SignUpControllerState(verification: $verification, submission: $submission, signedUpUser: $signedUpUser)';
}


}

/// @nodoc
abstract mixin class _$SignUpControllerStateCopyWith<$Res> implements $SignUpControllerStateCopyWith<$Res> {
  factory _$SignUpControllerStateCopyWith(_SignUpControllerState value, $Res Function(_SignUpControllerState) _then) = __$SignUpControllerStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<void> verification, AsyncValue<void> submission, CurrentUser? signedUpUser
});


@override $CurrentUserCopyWith<$Res>? get signedUpUser;

}
/// @nodoc
class __$SignUpControllerStateCopyWithImpl<$Res>
    implements _$SignUpControllerStateCopyWith<$Res> {
  __$SignUpControllerStateCopyWithImpl(this._self, this._then);

  final _SignUpControllerState _self;
  final $Res Function(_SignUpControllerState) _then;

/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verification = null,Object? submission = null,Object? signedUpUser = freezed,}) {
  return _then(_SignUpControllerState(
verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,signedUpUser: freezed == signedUpUser ? _self.signedUpUser : signedUpUser // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}

/// Create a copy of SignUpControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<$Res>? get signedUpUser {
    if (_self.signedUpUser == null) {
    return null;
  }

  return $CurrentUserCopyWith<$Res>(_self.signedUpUser!, (value) {
    return _then(_self.copyWith(signedUpUser: value));
  });
}
}

// dart format on
