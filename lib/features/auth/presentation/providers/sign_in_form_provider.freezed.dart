// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInFormState {

 String get businessNumber; String get password; bool get obscurePassword;
/// Create a copy of SignInFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInFormStateCopyWith<SignInFormState> get copyWith => _$SignInFormStateCopyWithImpl<SignInFormState>(this as SignInFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInFormState&&(identical(other.businessNumber, businessNumber) || other.businessNumber == businessNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword));
}


@override
int get hashCode => Object.hash(runtimeType,businessNumber,password,obscurePassword);



}

/// @nodoc
abstract mixin class $SignInFormStateCopyWith<$Res>  {
  factory $SignInFormStateCopyWith(SignInFormState value, $Res Function(SignInFormState) _then) = _$SignInFormStateCopyWithImpl;
@useResult
$Res call({
 String businessNumber, String password, bool obscurePassword
});




}
/// @nodoc
class _$SignInFormStateCopyWithImpl<$Res>
    implements $SignInFormStateCopyWith<$Res> {
  _$SignInFormStateCopyWithImpl(this._self, this._then);

  final SignInFormState _self;
  final $Res Function(SignInFormState) _then;

/// Create a copy of SignInFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessNumber = null,Object? password = null,Object? obscurePassword = null,}) {
  return _then(_self.copyWith(
businessNumber: null == businessNumber ? _self.businessNumber : businessNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInFormState].
extension SignInFormStatePatterns on SignInFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInFormState value)  $default,){
final _that = this;
switch (_that) {
case _SignInFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String businessNumber,  String password,  bool obscurePassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInFormState() when $default != null:
return $default(_that.businessNumber,_that.password,_that.obscurePassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String businessNumber,  String password,  bool obscurePassword)  $default,) {final _that = this;
switch (_that) {
case _SignInFormState():
return $default(_that.businessNumber,_that.password,_that.obscurePassword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String businessNumber,  String password,  bool obscurePassword)?  $default,) {final _that = this;
switch (_that) {
case _SignInFormState() when $default != null:
return $default(_that.businessNumber,_that.password,_that.obscurePassword);case _:
  return null;

}
}

}

/// @nodoc


class _SignInFormState extends SignInFormState {
  const _SignInFormState({this.businessNumber = '', this.password = '', this.obscurePassword = true}): super._();
  

@override@JsonKey() final  String businessNumber;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool obscurePassword;

/// Create a copy of SignInFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInFormStateCopyWith<_SignInFormState> get copyWith => __$SignInFormStateCopyWithImpl<_SignInFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInFormState&&(identical(other.businessNumber, businessNumber) || other.businessNumber == businessNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword));
}


@override
int get hashCode => Object.hash(runtimeType,businessNumber,password,obscurePassword);



}

/// @nodoc
abstract mixin class _$SignInFormStateCopyWith<$Res> implements $SignInFormStateCopyWith<$Res> {
  factory _$SignInFormStateCopyWith(_SignInFormState value, $Res Function(_SignInFormState) _then) = __$SignInFormStateCopyWithImpl;
@override @useResult
$Res call({
 String businessNumber, String password, bool obscurePassword
});




}
/// @nodoc
class __$SignInFormStateCopyWithImpl<$Res>
    implements _$SignInFormStateCopyWith<$Res> {
  __$SignInFormStateCopyWithImpl(this._self, this._then);

  final _SignInFormState _self;
  final $Res Function(_SignInFormState) _then;

/// Create a copy of SignInFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessNumber = null,Object? password = null,Object? obscurePassword = null,}) {
  return _then(_SignInFormState(
businessNumber: null == businessNumber ? _self.businessNumber : businessNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
