// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvalidCredentials value)?  invalidCredentials,TResult Function( Unauthorized value)?  unauthorized,TResult Function( CommonAuthFailure value)?  common,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvalidCredentials() when invalidCredentials != null:
return invalidCredentials(_that);case Unauthorized() when unauthorized != null:
return unauthorized(_that);case CommonAuthFailure() when common != null:
return common(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvalidCredentials value)  invalidCredentials,required TResult Function( Unauthorized value)  unauthorized,required TResult Function( CommonAuthFailure value)  common,}){
final _that = this;
switch (_that) {
case InvalidCredentials():
return invalidCredentials(_that);case Unauthorized():
return unauthorized(_that);case CommonAuthFailure():
return common(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvalidCredentials value)?  invalidCredentials,TResult? Function( Unauthorized value)?  unauthorized,TResult? Function( CommonAuthFailure value)?  common,}){
final _that = this;
switch (_that) {
case InvalidCredentials() when invalidCredentials != null:
return invalidCredentials(_that);case Unauthorized() when unauthorized != null:
return unauthorized(_that);case CommonAuthFailure() when common != null:
return common(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  invalidCredentials,TResult Function()?  unauthorized,TResult Function( CommonFailure failure)?  common,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvalidCredentials() when invalidCredentials != null:
return invalidCredentials();case Unauthorized() when unauthorized != null:
return unauthorized();case CommonAuthFailure() when common != null:
return common(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  invalidCredentials,required TResult Function()  unauthorized,required TResult Function( CommonFailure failure)  common,}) {final _that = this;
switch (_that) {
case InvalidCredentials():
return invalidCredentials();case Unauthorized():
return unauthorized();case CommonAuthFailure():
return common(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  invalidCredentials,TResult? Function()?  unauthorized,TResult? Function( CommonFailure failure)?  common,}) {final _that = this;
switch (_that) {
case InvalidCredentials() when invalidCredentials != null:
return invalidCredentials();case Unauthorized() when unauthorized != null:
return unauthorized();case CommonAuthFailure() when common != null:
return common(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class InvalidCredentials implements AuthFailure {
  const InvalidCredentials();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCredentials);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.invalidCredentials()';
}


}




/// @nodoc


class Unauthorized implements AuthFailure {
  const Unauthorized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthorized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.unauthorized()';
}


}




/// @nodoc


class CommonAuthFailure implements AuthFailure {
  const CommonAuthFailure(this.failure);
  

 final  CommonFailure failure;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonAuthFailureCopyWith<CommonAuthFailure> get copyWith => _$CommonAuthFailureCopyWithImpl<CommonAuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonAuthFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthFailure.common(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CommonAuthFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $CommonAuthFailureCopyWith(CommonAuthFailure value, $Res Function(CommonAuthFailure) _then) = _$CommonAuthFailureCopyWithImpl;
@useResult
$Res call({
 CommonFailure failure
});


$CommonFailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$CommonAuthFailureCopyWithImpl<$Res>
    implements $CommonAuthFailureCopyWith<$Res> {
  _$CommonAuthFailureCopyWithImpl(this._self, this._then);

  final CommonAuthFailure _self;
  final $Res Function(CommonAuthFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CommonAuthFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as CommonFailure,
  ));
}

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonFailureCopyWith<$Res> get failure {
  
  return $CommonFailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
