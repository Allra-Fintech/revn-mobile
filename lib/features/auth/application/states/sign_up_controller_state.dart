import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_user.dart';

part 'sign_up_controller_state.freezed.dart';

@freezed
sealed class SignUpControllerState with _$SignUpControllerState {
  const factory SignUpControllerState({
    @Default(AsyncData<void>(null)) AsyncValue<void> verification,
    @Default(AsyncData<void>(null)) AsyncValue<void> submission,
    CurrentUser? signedUpUser,
  }) = _SignUpControllerState;
}
