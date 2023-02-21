import 'package:flutter/material.dart';

import '../auth/auth_wrapper.dart';
import '../views/login.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, this.title = "Page", required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var auth = AuthWrapper.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(auth.authInformation.isLoggedIn() ? title : "Login"),
        ),
        body: auth.authInformation.isLoggedIn() ? child : const LoginView());
  }
}
