import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pending_social_link.dart';

part 'social_auth_state.freezed.dart';

@freezed
sealed class SocialAuthState with _$SocialAuthState {
  const factory SocialAuthState({
    @Default(AsyncData<void>(null)) AsyncValue<void> socialSignIn,
    PendingSocialLink? pendingLink,
  }) = _SocialAuthState;
}
