import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_information.g.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
@JsonSerializable()
class AuthInformation {
  String? refreshToken;
  String? idToken;
  String? accessToken;
  List<String>? scopes;
  String? tokenType;
  DateTime? accessTokenExpirationDateTime;
  String? state;

  AuthInformation.fromResponse(AuthorizationTokenResponse? authTokenResponse,
      TokenResponse? tokenResponse, EndSessionResponse? endSessionResponse) {
    refreshToken = authTokenResponse?.refreshToken ?? tokenResponse?.refreshToken;
    idToken = authTokenResponse?.idToken ?? tokenResponse?.idToken;
    accessToken = authTokenResponse?.accessToken ?? tokenResponse?.accessToken;
    scopes = authTokenResponse?.scopes ?? tokenResponse?.scopes;
    tokenType = authTokenResponse?.tokenType ?? tokenResponse?.tokenType;
    accessTokenExpirationDateTime = authTokenResponse?.accessTokenExpirationDateTime ?? tokenResponse?.accessTokenExpirationDateTime;
    state = endSessionResponse?.state;
  }



  AuthInformation({this.refreshToken, this.idToken, this.accessToken, this.scopes, this.tokenType, this.accessTokenExpirationDateTime, this.state});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory AuthInformation.fromJson(Map<String, dynamic> json) =>
      _$AuthInformationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AuthInformationToJson(this);
}
