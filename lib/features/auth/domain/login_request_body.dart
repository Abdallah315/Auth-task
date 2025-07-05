// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequestBody {
  final String phoneNumber;
  final String password;
  LoginRequestBody({required this.phoneNumber, required this.password});

  LoginRequestBody copyWith({String? phoneNumber, String? password}) {
    return LoginRequestBody(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'phoneNumber': phoneNumber, 'password': password};
  }

  factory LoginRequestBody.fromMap(Map<String, dynamic> map) {
    return LoginRequestBody(
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestBody.fromJson(String source) =>
      LoginRequestBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginRequestBody(phoneNumber: $phoneNumber, password: $password)';

  @override
  bool operator ==(covariant LoginRequestBody other) {
    if (identical(this, other)) return true;

    return other.phoneNumber == phoneNumber && other.password == password;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ password.hashCode;
}
