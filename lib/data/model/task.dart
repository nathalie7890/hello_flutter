import 'package:flutter/cupertino.dart';

@immutable
class Task {
  static const tableName = "tasks";
  final int id;
  final String title;
  final String desc;
  final int priority;
  final int userId;

  const Task(
      {this.id = -1,
      required this.title,
      required this.desc,
      required this.priority,
      required this.userId});

  Task copy(
      {int? id, String? title, String? desc, int? priority, int? userId}) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        priority: priority ?? this.priority,
        userId: userId ?? this.userId);
  }

  @override
  String toString() {
    return 'Task($id, $title, $desc, $priority)';
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "desc": desc,
      "priority": priority,
      "fk_user_id": userId
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        desc: map['desc'],
        priority: map["priority"] ?? 0,
        userId: map["fk_user_id"] ?? 0);
  }
}
