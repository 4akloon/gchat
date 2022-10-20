// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String phone;
  final String firstName;
  final String? lastName;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fullName => '$firstName ${lastName ?? ''}';

  UserModel({
    required this.id,
    required this.phone,
    required this.firstName,
    this.lastName,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? phone,
    String? firstName,
    String? lastName,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      phone: map['phone'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  factory UserModel.fromNetwork(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      phone: map['phone'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      bio: map['bio'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, phone: $phone, firstName: $firstName, lastName: $lastName, bio: $bio, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.phone == phone &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.bio == bio &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phone.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        bio.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  static const String graph =
      'id phone firstName lastName createdAt updatedAt bio';
}
