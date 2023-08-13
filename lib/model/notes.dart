import 'dart:convert';

import 'package:isar/isar.dart';

part 'notes.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  final String title;
  final String desc;
  final DateTime dateTime;
  final String color;

  Note(
      {required this.id,
      required this.title,
      required this.desc,
      required this.dateTime,
      this.color = "White"});

  Note copyWith({
    Id? id,
    String? title,
    String? desc,
    DateTime? dateTime,
    String? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      dateTime: dateTime ?? this.dateTime,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'color': color,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'] as String,
      desc: map['desc'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, desc: $desc, dateTime: $dateTime, color: $color)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.dateTime == dateTime &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        dateTime.hashCode ^
        color.hashCode;
  }
}
