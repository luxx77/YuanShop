import 'dart:convert';

class Conversation {
  final String name;
  final int id;
  Conversation({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversation_name': name,
      'id': id,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      name: map['conversation_name'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);
}
