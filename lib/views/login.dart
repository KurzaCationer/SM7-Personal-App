import 'package:flutter/material.dart';

import '../auth/auth_wrapper.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = AuthWrapper.of(context);
    return Column(
      children: [
        TextButton(onPressed: () => {auth.login()}, child: const Text("Login")),
        Text("Access Token: ${auth.authInformation.accessToken}")
      ],
    );
  }
}
