import 'package:flutter/material.dart';

import '../widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    '로그인',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '계정으로 로그인해서 서비스를 이용하세요.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 32),
                  SignInForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
