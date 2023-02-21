import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_project/auth/auth_wrapper.dart';

import 'base_page.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = AuthWrapper.of(context);
    return BasePage(
      title: "Home Page",
      child: Column(
        children: [
          TextButton(
              onPressed: () => {auth.login()},
              child: const Text("Login")),
          TextButton(
              onPressed: () => {auth.logout()},
              child: const Text("Logout")),
          TextButton(
              onPressed: () => {auth.refresh()},
              child: const Text("Refresh")),
          Text("Access Token: ${auth.authInformation.accessToken}")
        ],
      ),
    );
  }
}
