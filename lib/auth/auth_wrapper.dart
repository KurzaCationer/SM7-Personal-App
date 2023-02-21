import 'package:flutter/widgets.dart';
import 'package:test_project/auth/auth_information.dart';

import '../main.dart';

class AuthWrapper extends InheritedWidget{
  const AuthWrapper({
    super.key,
    required this.authInformation,
    required super.child,
  });

  final AuthInformation authInformation;

  void login(){
    fireLoginEvent.broadcast();
  }

  void logout(){
    fireLogoutEvent.broadcast();
  }

  void refresh(){
    fireRefreshEvent.broadcast();
  }

  static AuthWrapper? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthWrapper>();
  }

  static AuthWrapper of(BuildContext context) {
    final AuthWrapper? result = maybeOf(context);
    assert(result != null, 'No AuthWrapper found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AuthWrapper oldWidget) => authInformation.accessToken != oldWidget.authInformation.accessToken || authInformation.state  != oldWidget.authInformation.state;
}