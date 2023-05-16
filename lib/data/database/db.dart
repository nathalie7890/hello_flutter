import 'dart:typed_data';

import 'package:hello_flutter/data/model/user.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static Future<void> _createTables(Database db) async {
    await db.execute("""
      CREATE TABLE ${User.tableName} (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE ${Task.tableName}(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL,
        desc TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 0,
        fk_user_id INTEGER NOT NULL DEFAULT 0,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(fk_user_id) REFERENCES users(id)
      )
    """);
  }

  static Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  static Future _onUpgrade(Database database, int oldV, int newV) async {
    await database.execute("""
        ALTER TABLE ${User.tableName} ADD COLUMN image BLOB
      """);
  }

  static Future<Database> createDb() async {
    return await openDatabase(
        join(await getDatabasesPath(), "tasks_database.db"),
        version: 2, onConfigure: (Database database) async {
      await _onConfigure(database);
    }, onUpgrade: (Database database, int oldV, int newV) async {
      await _onUpgrade(database, oldV, newV);
    }, onCreate: (Database database, int version) async {
      await _createTables(database);
    });
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await createDb();
    return await db.query(Task.tableName, orderBy: "id");
  }

  static Future<int> createTask(Task task) async {
    final db = await createDb();
    return await db.insert(Task.tableName, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getTaskByUserId(int userId) async {
    final db = await createDb();
    return await db
        .query(Task.tableName, where: "fk_user_id = ?", whereArgs: [userId]);
  }

  static Future<List<Map<String, dynamic>>> getTask(int id) async {
    final db = await createDb();
    return await db.query(
      Task.tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }

  static Future<int> updateTask(task) async {
    final db = await createDb();
    return await db.update(Task.tableName, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
  }

  static Future<int> deleteTask(int id) async {
    final db = await createDb();
    return await db.delete(Task.tableName, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> createUser(User user) async {
    final db = await createDb();
    return db.insert(User.tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await createDb();
    return await db.query(User.tableName, orderBy: "id");
  }

  static Future<int> updateUser(User user) async {
    final db = await createDb();
    return await db.update(
      User.tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await createDb();
    return db.query(User.tableName,
        where: "email = ? ", whereArgs: [email], limit: 1);
  }

  static Future updateProfilePic(int userId, Uint8List image) async {
    final db = await createDb();
    db.update(User.tableName, {"image": image},
        where: "id = ?", whereArgs: [userId]);
  }
}
