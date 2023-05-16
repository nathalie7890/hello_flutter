import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/ui/home.dart";
import "package:hello_flutter/ui/login.dart";
import "package:hello_flutter/ui/persons.dart";
import "package:hello_flutter/ui/profile.dart";
import "package:hello_flutter/ui/ramen.dart";
import "package:hello_flutter/ui/register.dart";
import "package:hello_flutter/ui/switzerland.dart";
import "package:hello_flutter/ui/updateProduct.dart";
import "package:hello_flutter/ui/updateTask.dart";

import "addProduct.dart";
import "addTask.dart";

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  final String initialRoute;

  final _routes = [
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: "/register",
      name: "register",
      builder: (context, state) => const Register(),
    ),
    GoRoute(
        path: "/persons",
        name: "persons",
        builder: (context, state) => const Persons()),
    GoRoute(
        path: "/profile",
        name: "profile",
        builder: (context, state) => const Profile()),
    GoRoute(
        path: "/switzerland",
        name: "switzerland",
        builder: (context, state) => const Switzerland()),
    GoRoute(
        path: "/addTask",
        name: "addTask",
        builder: (context, state) => const AddTask()),
    GoRoute(
        path: "/addProduct",
        name: "addProduct",
        builder: (context, state) => const AddProduct()),
    GoRoute(
        path: "/updateProduct/:id",
        name: "updateProduct",
        builder: (context, state) =>
            UpdateProduct(id: state.pathParameters['id'] ?? "")),
    GoRoute(
        path: "/ramen",
        name: "ramen",
        builder: (context, state) => const Ramen()),
    GoRoute(
        path: "/updateTask/:id",
        name: "updateTask",
        builder: (context, state) =>
            UpdateTask(id: state.pathParameters['id'] ?? ""))
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MaterialApp.router(
          routerConfig:
              GoRouter(initialLocation: initialRoute, routes: _routes),
        ));
  }
}
