// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponseBody {
  final int id;
  final String? fullName;
  final String? email;
  final String phoneNumber;
  final String role;
  final bool isVerified;
  final DateTime? dateOfBirth;
  final String? profileImage;
  final String? gender;
  final String? maritalStatus;
  final DateTime createdAt;
  final String accessToken;
  LoginResponseBody({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.isVerified,
    required this.dateOfBirth,
    required this.profileImage,
    required this.gender,
    required this.maritalStatus,
    required this.createdAt,
    required this.accessToken,
  });

  LoginResponseBody copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    bool? isVerified,
    DateTime? dateOfBirth,
    String? profileImage,
    String? gender,
    String? maritalStatus,
    DateTime? createdAt,
    String? accessToken,
  }) {
    return LoginResponseBody(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      createdAt: createdAt ?? this.createdAt,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'isVerified': isVerified,
      'dateOfBirth': dateOfBirth?.toUtc().toIso8601String(),
      'profileImage': profileImage,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'accessToken': accessToken,
    };
  }

  factory LoginResponseBody.fromMap(Map<String, dynamic> map) {
    return LoginResponseBody(
      id: map['id'] as int,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      role: map['role'] as String,
      isVerified: map['isVerified'] as bool,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,
      profileImage: map['profileImage'] != null
          ? map['profileImage'] as String
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      maritalStatus: map['maritalStatus'] != null
          ? map['maritalStatus'] as String
          : null,
      createdAt: DateTime.parse(map['createdAt']),
      accessToken: map['accessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseBody.fromJson(String source) =>
      LoginResponseBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponseBody(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, role: $role, isVerified: $isVerified, dateOfBirth: $dateOfBirth, profileImage: $profileImage, gender: $gender, maritalStatus: $maritalStatus, createdAt: $createdAt, accessToken: $accessToken)';
  }

  @override
  bool operator ==(covariant LoginResponseBody other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        other.isVerified == isVerified &&
        other.dateOfBirth == dateOfBirth &&
        other.profileImage == profileImage &&
        other.gender == gender &&
        other.maritalStatus == maritalStatus &&
        other.createdAt == createdAt &&
        other.accessToken == accessToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        isVerified.hashCode ^
        dateOfBirth.hashCode ^
        profileImage.hashCode ^
        gender.hashCode ^
        maritalStatus.hashCode ^
        createdAt.hashCode ^
        accessToken.hashCode;
  }
}
