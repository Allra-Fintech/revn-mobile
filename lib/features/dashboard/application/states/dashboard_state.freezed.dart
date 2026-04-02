// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 String get userName; int get availableLimitAmount; String get limitTypeLabel; bool get hasExpiredTaxInvoice; bool get hasOverdueBalance; String? get zeroLimitReason;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.availableLimitAmount, availableLimitAmount) || other.availableLimitAmount == availableLimitAmount)&&(identical(other.limitTypeLabel, limitTypeLabel) || other.limitTypeLabel == limitTypeLabel)&&(identical(other.hasExpiredTaxInvoice, hasExpiredTaxInvoice) || other.hasExpiredTaxInvoice == hasExpiredTaxInvoice)&&(identical(other.hasOverdueBalance, hasOverdueBalance) || other.hasOverdueBalance == hasOverdueBalance)&&(identical(other.zeroLimitReason, zeroLimitReason) || other.zeroLimitReason == zeroLimitReason));
}


@override
int get hashCode => Object.hash(runtimeType,userName,availableLimitAmount,limitTypeLabel,hasExpiredTaxInvoice,hasOverdueBalance,zeroLimitReason);

@override
String toString() {
  return 'DashboardState(userName: $userName, availableLimitAmount: $availableLimitAmount, limitTypeLabel: $limitTypeLabel, hasExpiredTaxInvoice: $hasExpiredTaxInvoice, hasOverdueBalance: $hasOverdueBalance, zeroLimitReason: $zeroLimitReason)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 String userName, int availableLimitAmount, String limitTypeLabel, bool hasExpiredTaxInvoice, bool hasOverdueBalance, String? zeroLimitReason
});




}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = null,Object? availableLimitAmount = null,Object? limitTypeLabel = null,Object? hasExpiredTaxInvoice = null,Object? hasOverdueBalance = null,Object? zeroLimitReason = freezed,}) {
  return _then(_self.copyWith(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,availableLimitAmount: null == availableLimitAmount ? _self.availableLimitAmount : availableLimitAmount // ignore: cast_nullable_to_non_nullable
as int,limitTypeLabel: null == limitTypeLabel ? _self.limitTypeLabel : limitTypeLabel // ignore: cast_nullable_to_non_nullable
as String,hasExpiredTaxInvoice: null == hasExpiredTaxInvoice ? _self.hasExpiredTaxInvoice : hasExpiredTaxInvoice // ignore: cast_nullable_to_non_nullable
as bool,hasOverdueBalance: null == hasOverdueBalance ? _self.hasOverdueBalance : hasOverdueBalance // ignore: cast_nullable_to_non_nullable
as bool,zeroLimitReason: freezed == zeroLimitReason ? _self.zeroLimitReason : zeroLimitReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userName,  int availableLimitAmount,  String limitTypeLabel,  bool hasExpiredTaxInvoice,  bool hasOverdueBalance,  String? zeroLimitReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.userName,_that.availableLimitAmount,_that.limitTypeLabel,_that.hasExpiredTaxInvoice,_that.hasOverdueBalance,_that.zeroLimitReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userName,  int availableLimitAmount,  String limitTypeLabel,  bool hasExpiredTaxInvoice,  bool hasOverdueBalance,  String? zeroLimitReason)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.userName,_that.availableLimitAmount,_that.limitTypeLabel,_that.hasExpiredTaxInvoice,_that.hasOverdueBalance,_that.zeroLimitReason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userName,  int availableLimitAmount,  String limitTypeLabel,  bool hasExpiredTaxInvoice,  bool hasOverdueBalance,  String? zeroLimitReason)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.userName,_that.availableLimitAmount,_that.limitTypeLabel,_that.hasExpiredTaxInvoice,_that.hasOverdueBalance,_that.zeroLimitReason);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({required this.userName, required this.availableLimitAmount, required this.limitTypeLabel, this.hasExpiredTaxInvoice = false, this.hasOverdueBalance = false, this.zeroLimitReason});
  

@override final  String userName;
@override final  int availableLimitAmount;
@override final  String limitTypeLabel;
@override@JsonKey() final  bool hasExpiredTaxInvoice;
@override@JsonKey() final  bool hasOverdueBalance;
@override final  String? zeroLimitReason;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.availableLimitAmount, availableLimitAmount) || other.availableLimitAmount == availableLimitAmount)&&(identical(other.limitTypeLabel, limitTypeLabel) || other.limitTypeLabel == limitTypeLabel)&&(identical(other.hasExpiredTaxInvoice, hasExpiredTaxInvoice) || other.hasExpiredTaxInvoice == hasExpiredTaxInvoice)&&(identical(other.hasOverdueBalance, hasOverdueBalance) || other.hasOverdueBalance == hasOverdueBalance)&&(identical(other.zeroLimitReason, zeroLimitReason) || other.zeroLimitReason == zeroLimitReason));
}


@override
int get hashCode => Object.hash(runtimeType,userName,availableLimitAmount,limitTypeLabel,hasExpiredTaxInvoice,hasOverdueBalance,zeroLimitReason);

@override
String toString() {
  return 'DashboardState(userName: $userName, availableLimitAmount: $availableLimitAmount, limitTypeLabel: $limitTypeLabel, hasExpiredTaxInvoice: $hasExpiredTaxInvoice, hasOverdueBalance: $hasOverdueBalance, zeroLimitReason: $zeroLimitReason)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 String userName, int availableLimitAmount, String limitTypeLabel, bool hasExpiredTaxInvoice, bool hasOverdueBalance, String? zeroLimitReason
});




}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = null,Object? availableLimitAmount = null,Object? limitTypeLabel = null,Object? hasExpiredTaxInvoice = null,Object? hasOverdueBalance = null,Object? zeroLimitReason = freezed,}) {
  return _then(_DashboardState(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,availableLimitAmount: null == availableLimitAmount ? _self.availableLimitAmount : availableLimitAmount // ignore: cast_nullable_to_non_nullable
as int,limitTypeLabel: null == limitTypeLabel ? _self.limitTypeLabel : limitTypeLabel // ignore: cast_nullable_to_non_nullable
as String,hasExpiredTaxInvoice: null == hasExpiredTaxInvoice ? _self.hasExpiredTaxInvoice : hasExpiredTaxInvoice // ignore: cast_nullable_to_non_nullable
as bool,hasOverdueBalance: null == hasOverdueBalance ? _self.hasOverdueBalance : hasOverdueBalance // ignore: cast_nullable_to_non_nullable
as bool,zeroLimitReason: freezed == zeroLimitReason ? _self.zeroLimitReason : zeroLimitReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
