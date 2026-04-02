import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/application/states/social_auth_state.dart';

class TestSocialAuthController extends SocialAuthController {
  TestSocialAuthController(this._initialState);

  final SocialAuthState _initialState;

  @override
  SocialAuthState build() => _initialState;

  void setStateForTest(SocialAuthState next) {
    state = next;
  }
}
