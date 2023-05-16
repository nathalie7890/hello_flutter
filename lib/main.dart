import 'package:flutter/material.dart';
import "package:hello_flutter/data/database/db.dart";
import "package:hello_flutter/ui/navigation.dart";
import "service/auth_service.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.createDb();
  final isLoggedIn = await AuthService.isLoggedIn();
  runApp(MyApp(initialRoute: isLoggedIn ? "/home" : "/login"));
}
