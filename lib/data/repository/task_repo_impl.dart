import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/database/db.dart';
import 'package:hello_flutter/data/model/task.dart';
import 'package:hello_flutter/data/repository/task_repo.dart';

class TasksRepoImpl extends TasksRepo {
  static final TasksRepoImpl _instance = TasksRepoImpl._internal();

  factory TasksRepoImpl() {
    return _instance;
  }

  TasksRepoImpl._internal();

  @override
  Future<List<Task>> getTasks() async {
    final res = await TaskDatabase.getTasks();
    return res.map((e) => Task.fromMap(e)).toList();
  }

  @override
  Future<bool> createTask(Task task) async {
    debugPrint(task.userId.toString());
    await TaskDatabase.createTask(task);
    return true;
  }

  @override
  Future<bool> deleteTask(int id) async {
    await TaskDatabase.deleteTask(id);
    return true;
  }

  @override
  Future<Task?> getTask(int id) async {
    final res = await TaskDatabase.getTask(id);
    if (res.isEmpty) {
      return null;
    }
    return Task.fromMap(res[0]);
  }

  @override
  Future<List<Task>> getTaskByUserId(int userId) async {
    final res = await TaskDatabase.getTaskByUserId(userId);
    return res.map((e) => Task.fromMap(e)).toList();
  }

  @override
  Future<bool> updateTask(Task task) async {
    await TaskDatabase.updateTask(task);
    return true;
  }
}
