// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gchat/models/user/user.model.dart';

class LoginModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  LoginModel copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return LoginModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toMap(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  factory LoginModel.fromNetwork(Map<String, dynamic> map) {
    return LoginModel(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      user: UserModel.fromNetwork(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginModel(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.user == user;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ user.hashCode;
}
