// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel {
  final String? text;
  final List<String> files;
  MessageModel({
    this.text,
    this.files = const [],
  });

  MessageModel copyWith({
    String? text,
    List<String>? files,
  }) {
    return MessageModel(
      text: text ?? this.text,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'files': files,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] != null ? map['text'] as String : null,
      files: List<String>.from((map['files'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageModel(text: $text, files: $files)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.text == text && listEquals(other.files, files);
  }

  @override
  int get hashCode => text.hashCode ^ files.hashCode;
}
