// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class Message {
  int id;
  String body;
  String type;
  String date;
  String hour;
  bool is_seen;
  bool is_owner;
  XFile? image;

  Message({
    required this.date,
    required this.id,
    required this.is_owner,
    required this.body,
    required this.type,
    required this.hour,
    this.is_seen = false,
    this.image,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      body: map['body'] as String,
      type: map['type'] as String,
      date: map['date'] as String,
      hour: map['hour'] as String,
      is_seen: map['is_seen'] as bool,
      is_owner: map['is_owner'] as bool,
      image: map['image'],
    );
  }

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
