import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_project/auth/auth_information.dart';
import 'package:test_project/auth/auth_wrapper.dart';
import 'package:event/event.dart';

import 'auth/auth.dart';
import 'pages/home.dart';

Future<void> main() async {
  runApp(const MyApp());
}

final fireLoginEvent = Event();
final fireLogoutEvent = Event();
final fireRefreshEvent = Event();

bool initialized = false;
bool busy = false;

class MyApp extends HookWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    var authInformation = useState(AuthInformation());

    setupEvents(authInformation);

    if (!initialized) initializeApp(authInformation);

    return AuthWrapper(
        authInformation: authInformation.value,
        child: const MaterialApp(
          home: HomePage(),
        ));
  }

  void setupEvents(ValueNotifier<AuthInformation> authInformation) {
    fireLoginEvent.unsubscribeAll();
    fireLogoutEvent.unsubscribeAll();
    fireRefreshEvent.unsubscribeAll();

    fireLoginEvent.subscribe((args) async {
      if (busy) return;

      busy = true;
      authInformation.value = await Auth.login();
      await Auth.save(authInformation.value);
      busy = false;
    });

    fireLogoutEvent.subscribe((args) async {
      if (busy) return;
      if (authInformation.value.idToken == null) return;

      busy = true;
      authInformation.value = await Auth.logout(authInformation.value.idToken!);
      await Auth.save(authInformation.value);
      busy = false;
    });

    fireRefreshEvent.subscribe((args) async {
      if (busy) return;
      if (authInformation.value.refreshToken == null) return;

      busy = true;
      authInformation.value = await Auth.refresh(authInformation.value.refreshToken!);
      await Auth.save(authInformation.value);
      busy = false;
    });
  }

  void initializeApp(ValueNotifier<AuthInformation> authInformation) {
    busy = true;

    Auth.retrieve().then((initialAuthInformation) {
      if (initialAuthInformation.refreshToken != null &&
          initialAuthInformation.refreshToken != "" &&
          initialized == false) {
        Auth.refresh(initialAuthInformation.refreshToken!).then((value) async {
          authInformation.value = value;
          await Auth.save(authInformation.value);
          busy = false;
          initialized = true;
        }).catchError((obj) {
          busy = false;
          initialized = true;
        });
      } else {
        busy = false;
        initialized = true;
      }
    });
  }
}
