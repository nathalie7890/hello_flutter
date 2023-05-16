import "dart:ffi";

import "../model/task.dart";

abstract class TasksRepo {
  Future<List<Task>> getTasks();
  Future<List<Task>> getTaskByUserId(int userId);
  Future<bool> createTask(Task task);
  Future<Task?> getTask(int id);
  Future<bool> updateTask(Task task);
  Future<bool> deleteTask(int id);
}
