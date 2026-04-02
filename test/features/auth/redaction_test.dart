import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/data/dtos/sign_in_request_dto.dart';
import 'package:revn/features/auth/data/dtos/sign_in_response_dto.dart';
import 'package:revn/features/auth/data/dtos/user_dto.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/entities/pending_social_link.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
import 'package:revn/features/auth/presentation/providers/sign_in_form_provider.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

void main() {
  test('sensitive auth models redact credentials in toString', () {
    final signInRequest = SignInRequestDto(
      businessNumber: '1234567890',
      password: 'super-secret',
    );
    final signInResponse = SignInResponseDto(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      user: const UserDto(
        id: 'user-id',
        businessNumber: '1234567890',
        username: 'owner',
      ),
    );
    const currentUser = CurrentUser(
      id: 'user-id',
      businessNumber: '1234567890',
      username: 'owner',
    );
    const pendingLink = PendingSocialLink(
      provider: SocialProvider.kakao,
      accessToken: 'pending-token',
      lastErrorMessage: 'failed',
    );
    const signInFormState = SignInFormState(
      businessNumber: '1234567890',
      password: 'super-secret',
    );
    const signUpFlowState = SignUpFlowState(
      step: SignUpStep.credentials,
      businessNumber: '1234567890',
      verifiedBusinessNumber: '1234567890',
      password: 'super-secret',
      passwordConfirmation: 'super-secret',
    );

    expect(signInRequest.toString(), isNot(contains('1234567890')));
    expect(signInRequest.toString(), isNot(contains('super-secret')));

    expect(signInResponse.toString(), isNot(contains('access-token')));
    expect(signInResponse.toString(), isNot(contains('refresh-token')));
    expect(signInResponse.toString(), isNot(contains('owner')));

    expect(currentUser.toString(), isNot(contains('user-id')));
    expect(currentUser.toString(), isNot(contains('1234567890')));
    expect(currentUser.toString(), isNot(contains('owner')));

    expect(pendingLink.toString(), isNot(contains('pending-token')));

    expect(signInFormState.toString(), isNot(contains('1234567890')));
    expect(signInFormState.toString(), isNot(contains('super-secret')));

    expect(signUpFlowState.toString(), isNot(contains('1234567890')));
    expect(signUpFlowState.toString(), isNot(contains('super-secret')));
  });
}
