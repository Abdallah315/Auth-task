// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterRequestBody {
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;
  RegisterRequestBody({
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  RegisterRequestBody copyWith({
    String? phoneNumber,
    String? password,
    String? passwordConfirmation,
  }) {
    return RegisterRequestBody(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }

  factory RegisterRequestBody.fromMap(Map<String, dynamic> map) {
    return RegisterRequestBody(
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestBody.fromJson(String source) =>
      RegisterRequestBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterRequestBody(phoneNumber: $phoneNumber, password: $password, passwordConfirmation: $passwordConfirmation)';

  @override
  bool operator ==(covariant RegisterRequestBody other) {
    if (identical(this, other)) return true;

    return other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode =>
      phoneNumber.hashCode ^ password.hashCode ^ passwordConfirmation.hashCode;
}
