// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStates {
  final String stateName;
  final String doneAt;
  OrderStates({
    required this.stateName,
    required this.doneAt,
  });

  OrderStates copyWith({
    String? stateName,
    String? doneAt,
  }) {
    return OrderStates(
      stateName: stateName ?? this.stateName,
      doneAt: doneAt ?? this.doneAt,
    );
  }
  // delivery_info

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stateName': stateName,
      'doneAt': doneAt,
    };
  }

  factory OrderStates.fromMap(Map<String, dynamic> map) {
    return OrderStates(
      stateName: map['stateName'] as String,
      doneAt: map['doneAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStates.fromJson(String source) =>
      OrderStates.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderStates(stateName: $stateName, doneAt: $doneAt)';

  @override
  bool operator ==(covariant OrderStates other) {
    if (identical(this, other)) return true;

    return other.stateName == stateName && other.doneAt == doneAt;
  }

  @override
  int get hashCode => stateName.hashCode ^ doneAt.hashCode;
}
