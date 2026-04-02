import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_user.dart';

part 'sign_in_controller_state.freezed.dart';

@freezed
sealed class SignInControllerState with _$SignInControllerState {
  const factory SignInControllerState({
    @Default(AsyncData<void>(null)) AsyncValue<void> submission,
    CurrentUser? signedInUser,
  }) = _SignInControllerState;
}
