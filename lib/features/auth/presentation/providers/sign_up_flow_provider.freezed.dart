// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_flow_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpFlowState {

 SignUpStep get step; bool get serviceTermsAgreed; bool get privacyCollectionAgreed; bool get privacySharingAgreed; bool get marketingAgreed; String get businessNumber; String? get verifiedBusinessNumber; String get password; String get passwordConfirmation; bool get obscurePassword; bool get obscurePasswordConfirmation;
/// Create a copy of SignUpFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpFlowStateCopyWith<SignUpFlowState> get copyWith => _$SignUpFlowStateCopyWithImpl<SignUpFlowState>(this as SignUpFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFlowState&&(identical(other.step, step) || other.step == step)&&(identical(other.serviceTermsAgreed, serviceTermsAgreed) || other.serviceTermsAgreed == serviceTermsAgreed)&&(identical(other.privacyCollectionAgreed, privacyCollectionAgreed) || other.privacyCollectionAgreed == privacyCollectionAgreed)&&(identical(other.privacySharingAgreed, privacySharingAgreed) || other.privacySharingAgreed == privacySharingAgreed)&&(identical(other.marketingAgreed, marketingAgreed) || other.marketingAgreed == marketingAgreed)&&(identical(other.businessNumber, businessNumber) || other.businessNumber == businessNumber)&&(identical(other.verifiedBusinessNumber, verifiedBusinessNumber) || other.verifiedBusinessNumber == verifiedBusinessNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscurePasswordConfirmation, obscurePasswordConfirmation) || other.obscurePasswordConfirmation == obscurePasswordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,step,serviceTermsAgreed,privacyCollectionAgreed,privacySharingAgreed,marketingAgreed,businessNumber,verifiedBusinessNumber,password,passwordConfirmation,obscurePassword,obscurePasswordConfirmation);

@override
String toString() {
  return 'SignUpFlowState(step: $step, serviceTermsAgreed: $serviceTermsAgreed, privacyCollectionAgreed: $privacyCollectionAgreed, privacySharingAgreed: $privacySharingAgreed, marketingAgreed: $marketingAgreed, businessNumber: $businessNumber, verifiedBusinessNumber: $verifiedBusinessNumber, password: $password, passwordConfirmation: $passwordConfirmation, obscurePassword: $obscurePassword, obscurePasswordConfirmation: $obscurePasswordConfirmation)';
}


}

/// @nodoc
abstract mixin class $SignUpFlowStateCopyWith<$Res>  {
  factory $SignUpFlowStateCopyWith(SignUpFlowState value, $Res Function(SignUpFlowState) _then) = _$SignUpFlowStateCopyWithImpl;
@useResult
$Res call({
 SignUpStep step, bool serviceTermsAgreed, bool privacyCollectionAgreed, bool privacySharingAgreed, bool marketingAgreed, String businessNumber, String? verifiedBusinessNumber, String password, String passwordConfirmation, bool obscurePassword, bool obscurePasswordConfirmation
});




}
/// @nodoc
class _$SignUpFlowStateCopyWithImpl<$Res>
    implements $SignUpFlowStateCopyWith<$Res> {
  _$SignUpFlowStateCopyWithImpl(this._self, this._then);

  final SignUpFlowState _self;
  final $Res Function(SignUpFlowState) _then;

/// Create a copy of SignUpFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? serviceTermsAgreed = null,Object? privacyCollectionAgreed = null,Object? privacySharingAgreed = null,Object? marketingAgreed = null,Object? businessNumber = null,Object? verifiedBusinessNumber = freezed,Object? password = null,Object? passwordConfirmation = null,Object? obscurePassword = null,Object? obscurePasswordConfirmation = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignUpStep,serviceTermsAgreed: null == serviceTermsAgreed ? _self.serviceTermsAgreed : serviceTermsAgreed // ignore: cast_nullable_to_non_nullable
as bool,privacyCollectionAgreed: null == privacyCollectionAgreed ? _self.privacyCollectionAgreed : privacyCollectionAgreed // ignore: cast_nullable_to_non_nullable
as bool,privacySharingAgreed: null == privacySharingAgreed ? _self.privacySharingAgreed : privacySharingAgreed // ignore: cast_nullable_to_non_nullable
as bool,marketingAgreed: null == marketingAgreed ? _self.marketingAgreed : marketingAgreed // ignore: cast_nullable_to_non_nullable
as bool,businessNumber: null == businessNumber ? _self.businessNumber : businessNumber // ignore: cast_nullable_to_non_nullable
as String,verifiedBusinessNumber: freezed == verifiedBusinessNumber ? _self.verifiedBusinessNumber : verifiedBusinessNumber // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscurePasswordConfirmation: null == obscurePasswordConfirmation ? _self.obscurePasswordConfirmation : obscurePasswordConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpFlowState].
extension SignUpFlowStatePatterns on SignUpFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpFlowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpFlowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpFlowState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpFlowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpFlowState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpFlowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SignUpStep step,  bool serviceTermsAgreed,  bool privacyCollectionAgreed,  bool privacySharingAgreed,  bool marketingAgreed,  String businessNumber,  String? verifiedBusinessNumber,  String password,  String passwordConfirmation,  bool obscurePassword,  bool obscurePasswordConfirmation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpFlowState() when $default != null:
return $default(_that.step,_that.serviceTermsAgreed,_that.privacyCollectionAgreed,_that.privacySharingAgreed,_that.marketingAgreed,_that.businessNumber,_that.verifiedBusinessNumber,_that.password,_that.passwordConfirmation,_that.obscurePassword,_that.obscurePasswordConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SignUpStep step,  bool serviceTermsAgreed,  bool privacyCollectionAgreed,  bool privacySharingAgreed,  bool marketingAgreed,  String businessNumber,  String? verifiedBusinessNumber,  String password,  String passwordConfirmation,  bool obscurePassword,  bool obscurePasswordConfirmation)  $default,) {final _that = this;
switch (_that) {
case _SignUpFlowState():
return $default(_that.step,_that.serviceTermsAgreed,_that.privacyCollectionAgreed,_that.privacySharingAgreed,_that.marketingAgreed,_that.businessNumber,_that.verifiedBusinessNumber,_that.password,_that.passwordConfirmation,_that.obscurePassword,_that.obscurePasswordConfirmation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SignUpStep step,  bool serviceTermsAgreed,  bool privacyCollectionAgreed,  bool privacySharingAgreed,  bool marketingAgreed,  String businessNumber,  String? verifiedBusinessNumber,  String password,  String passwordConfirmation,  bool obscurePassword,  bool obscurePasswordConfirmation)?  $default,) {final _that = this;
switch (_that) {
case _SignUpFlowState() when $default != null:
return $default(_that.step,_that.serviceTermsAgreed,_that.privacyCollectionAgreed,_that.privacySharingAgreed,_that.marketingAgreed,_that.businessNumber,_that.verifiedBusinessNumber,_that.password,_that.passwordConfirmation,_that.obscurePassword,_that.obscurePasswordConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpFlowState implements SignUpFlowState {
  const _SignUpFlowState({this.step = SignUpStep.agreements, this.serviceTermsAgreed = false, this.privacyCollectionAgreed = false, this.privacySharingAgreed = false, this.marketingAgreed = false, this.businessNumber = '', this.verifiedBusinessNumber, this.password = '', this.passwordConfirmation = '', this.obscurePassword = true, this.obscurePasswordConfirmation = true});
  

@override@JsonKey() final  SignUpStep step;
@override@JsonKey() final  bool serviceTermsAgreed;
@override@JsonKey() final  bool privacyCollectionAgreed;
@override@JsonKey() final  bool privacySharingAgreed;
@override@JsonKey() final  bool marketingAgreed;
@override@JsonKey() final  String businessNumber;
@override final  String? verifiedBusinessNumber;
@override@JsonKey() final  String password;
@override@JsonKey() final  String passwordConfirmation;
@override@JsonKey() final  bool obscurePassword;
@override@JsonKey() final  bool obscurePasswordConfirmation;

/// Create a copy of SignUpFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpFlowStateCopyWith<_SignUpFlowState> get copyWith => __$SignUpFlowStateCopyWithImpl<_SignUpFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpFlowState&&(identical(other.step, step) || other.step == step)&&(identical(other.serviceTermsAgreed, serviceTermsAgreed) || other.serviceTermsAgreed == serviceTermsAgreed)&&(identical(other.privacyCollectionAgreed, privacyCollectionAgreed) || other.privacyCollectionAgreed == privacyCollectionAgreed)&&(identical(other.privacySharingAgreed, privacySharingAgreed) || other.privacySharingAgreed == privacySharingAgreed)&&(identical(other.marketingAgreed, marketingAgreed) || other.marketingAgreed == marketingAgreed)&&(identical(other.businessNumber, businessNumber) || other.businessNumber == businessNumber)&&(identical(other.verifiedBusinessNumber, verifiedBusinessNumber) || other.verifiedBusinessNumber == verifiedBusinessNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscurePasswordConfirmation, obscurePasswordConfirmation) || other.obscurePasswordConfirmation == obscurePasswordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,step,serviceTermsAgreed,privacyCollectionAgreed,privacySharingAgreed,marketingAgreed,businessNumber,verifiedBusinessNumber,password,passwordConfirmation,obscurePassword,obscurePasswordConfirmation);

@override
String toString() {
  return 'SignUpFlowState(step: $step, serviceTermsAgreed: $serviceTermsAgreed, privacyCollectionAgreed: $privacyCollectionAgreed, privacySharingAgreed: $privacySharingAgreed, marketingAgreed: $marketingAgreed, businessNumber: $businessNumber, verifiedBusinessNumber: $verifiedBusinessNumber, password: $password, passwordConfirmation: $passwordConfirmation, obscurePassword: $obscurePassword, obscurePasswordConfirmation: $obscurePasswordConfirmation)';
}


}

/// @nodoc
abstract mixin class _$SignUpFlowStateCopyWith<$Res> implements $SignUpFlowStateCopyWith<$Res> {
  factory _$SignUpFlowStateCopyWith(_SignUpFlowState value, $Res Function(_SignUpFlowState) _then) = __$SignUpFlowStateCopyWithImpl;
@override @useResult
$Res call({
 SignUpStep step, bool serviceTermsAgreed, bool privacyCollectionAgreed, bool privacySharingAgreed, bool marketingAgreed, String businessNumber, String? verifiedBusinessNumber, String password, String passwordConfirmation, bool obscurePassword, bool obscurePasswordConfirmation
});




}
/// @nodoc
class __$SignUpFlowStateCopyWithImpl<$Res>
    implements _$SignUpFlowStateCopyWith<$Res> {
  __$SignUpFlowStateCopyWithImpl(this._self, this._then);

  final _SignUpFlowState _self;
  final $Res Function(_SignUpFlowState) _then;

/// Create a copy of SignUpFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? serviceTermsAgreed = null,Object? privacyCollectionAgreed = null,Object? privacySharingAgreed = null,Object? marketingAgreed = null,Object? businessNumber = null,Object? verifiedBusinessNumber = freezed,Object? password = null,Object? passwordConfirmation = null,Object? obscurePassword = null,Object? obscurePasswordConfirmation = null,}) {
  return _then(_SignUpFlowState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignUpStep,serviceTermsAgreed: null == serviceTermsAgreed ? _self.serviceTermsAgreed : serviceTermsAgreed // ignore: cast_nullable_to_non_nullable
as bool,privacyCollectionAgreed: null == privacyCollectionAgreed ? _self.privacyCollectionAgreed : privacyCollectionAgreed // ignore: cast_nullable_to_non_nullable
as bool,privacySharingAgreed: null == privacySharingAgreed ? _self.privacySharingAgreed : privacySharingAgreed // ignore: cast_nullable_to_non_nullable
as bool,marketingAgreed: null == marketingAgreed ? _self.marketingAgreed : marketingAgreed // ignore: cast_nullable_to_non_nullable
as bool,businessNumber: null == businessNumber ? _self.businessNumber : businessNumber // ignore: cast_nullable_to_non_nullable
as String,verifiedBusinessNumber: freezed == verifiedBusinessNumber ? _self.verifiedBusinessNumber : verifiedBusinessNumber // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscurePasswordConfirmation: null == obscurePasswordConfirmation ? _self.obscurePasswordConfirmation : obscurePasswordConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
