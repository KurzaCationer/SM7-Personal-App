import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, this.title = "Page", required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: child
    );
  }
}