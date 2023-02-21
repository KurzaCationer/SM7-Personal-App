import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_information.dart';

const identitySecureStorageKey = "auth_information";

class Auth {
  static const String clientId = "202066858621337685@sm7_personal_project";
  static const String redirectUri = "nl.kurza.test-project.auth://callback";
  static const String postLogoutUri = "nl.kurza.test-project.auth://post-logout";
  static const String discoveryUri = "https://identity.kurza.nl/.well-known/openid-configuration";
  static const List<String> scopes = ["openid", "profile", "email", "offline_access"];

  static const FlutterAppAuth appAuth = FlutterAppAuth();
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<AuthInformation> retrieve() async {
    var values = await storage.read(key: identitySecureStorageKey);

    if (values == null) return AuthInformation();

    return AuthInformation.fromJson(jsonDecode(values));
  }

  static Future<void> save(AuthInformation identityInformation) async {
    var values = jsonEncode(identityInformation);

    await storage.write(key: identitySecureStorageKey, value: values);
  }

  static Future<AuthInformation> login() async {
    var response = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientId, redirectUri, discoveryUrl: discoveryUri, scopes: scopes));

    return AuthInformation.fromResponse(response, null, null);
  }

  static Future<AuthInformation> refresh(String refreshToken) async {
    var response = await appAuth.token(
        TokenRequest(clientId, redirectUri, refreshToken: refreshToken, discoveryUrl: discoveryUri, scopes: scopes));
    return AuthInformation.fromResponse(null, response, null);
  }

  static Future<AuthInformation> logout(String idToken) async {
    var response = await appAuth.endSession(
        EndSessionRequest(idTokenHint: idToken, postLogoutRedirectUrl: postLogoutUri, discoveryUrl: discoveryUri));
    return AuthInformation.fromResponse(null, null, response);
  }

  static void addScope(String scope) {
    if (!scopes.contains(scope)) {
      scopes.add(scope);
    }
  }
}
