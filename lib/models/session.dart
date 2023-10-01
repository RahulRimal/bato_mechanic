import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionsToJson(List<Session> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Session {
  Session({
    required this.accessToken,
    required this.refreshToken,
  });

  String accessToken;

  String refreshToken;

  String get sessionAccessToken {
    return accessToken;
  }

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        accessToken: json["access"],
        refreshToken: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(accessToken: map['access'], refreshToken: map['refresh']);
  }
}

class SessionError {
  int code;
  Object message;

  SessionError({required this.code, required this.message});
}
