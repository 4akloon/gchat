// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gchat/models/user/user.model.dart';

class ContactModel {
  final String id;
  final UserModel owner;
  final UserModel member;
  final DateTime createdAt;
  final DateTime updatedAt;
  ContactModel({
    required this.id,
    required this.owner,
    required this.member,
    required this.createdAt,
    required this.updatedAt,
  });

  ContactModel copyWith({
    String? id,
    UserModel? owner,
    UserModel? member,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      member: member ?? this.member,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner': owner.toMap(),
      'member': member.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      owner: UserModel.fromMap(map['owner'] as Map<String, dynamic>),
      member: UserModel.fromMap(map['member'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  factory ContactModel.fromNetwork(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      owner: UserModel.fromNetwork(map['owner']),
      member: UserModel.fromNetwork(map['member']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactModel(id: $id, owner: $owner, member: $member, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ContactModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.owner == owner &&
        other.member == member &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        owner.hashCode ^
        member.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  static const String graph =
      'id owner { ${UserModel.graph} } member { ${UserModel.graph} } createdAt updatedAt';
}
