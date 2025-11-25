// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthResponseModel {
  final String access;
  final String refresh;
  final String role;

  AuthResponseModel({
    required this.access,
    required this.refresh,
    required this.role,
  });

  AuthResponseModel copyWith({String? access, String? refresh, String? role}) =>
      AuthResponseModel(
        access: access ?? this.access,
        refresh: refresh ?? this.refresh,
        role: role ?? this.role,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access': access,
      'refresh': refresh,
      'role': role,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      access: map['access'] as String,
      refresh: map['refresh'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
