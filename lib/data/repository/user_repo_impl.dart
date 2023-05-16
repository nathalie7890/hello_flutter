import 'dart:typed_data';

import 'package:hello_flutter/data/database/db.dart';
import '../model/user.dart';

class UserRepoImpl {
  Future<int> insertUser(User user) async {
    return await TaskDatabase.createUser(user);
  }

  Future<List<User>> getUsers() async {
    final res = await TaskDatabase.getUsers();
    return res.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getUserByEmail(String email) async {
    final res = await TaskDatabase.getUserByEmail(email);
    if (res.isEmpty) {
      return null;
    }
    return User.fromMap(res[0]);
  }

  Future<bool> updateUser(User user) async {
    await TaskDatabase.updateUser(user);
    return true;
  }

  Future updateProfilePic(int userId, Uint8List image) async {
    await TaskDatabase.updateProfilePic(userId, image);
  }
}
