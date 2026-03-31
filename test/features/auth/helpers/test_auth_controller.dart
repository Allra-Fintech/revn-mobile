import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';

class TestAuthController extends AuthController {
  TestAuthController(this._initialState);

  final AuthState _initialState;

  int restoreSessionCallCount = 0;
  int signOutCallCount = 0;

  @override
  AuthState build() => _initialState;

  @override
  Future<void> restoreSession() async {
    restoreSessionCallCount++;
  }

  @override
  Future<void> signOut() async {
    signOutCallCount++;
    state = const AuthState.unauthenticated();
  }

  void setStateForTest(AuthState next) {
    state = next;
  }
}
