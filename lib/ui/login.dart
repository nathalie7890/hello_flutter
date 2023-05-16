import "package:flutter/material.dart";
import "package:hello_flutter/colors.dart";
import "package:hello_flutter/service/auth_service.dart";
import "package:hello_flutter/ui/profile.dart";
import "package:go_router/go_router.dart";

import "../data/model/user.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = "";
  var _emailError = "";
  var _password = "";
  var _passwordError = "";

  _onEmailChanged(value) {
    setState(() {
      _email = value;
    });
  }

  _onPasswordChanged(value) {
    setState(() {
      _password = value;
    });
  }

  _onClickLogin() {
    setState(() {
      if (_email.isEmpty) {
        _emailError = "Invalid input";
        return;
      } else {
        _emailError = "";
      }

      if (_password.isEmpty) {
        _passwordError = "Invalid input";
        return;
      } else {
        _passwordError = "";
      }

      AuthService.authenticate(
          _email, _password,
          (status) => {
                if (status)
                  context.go("/home")
                else
                  debugPrint("Wrong credentials")
              });
    });
  }

  _goToRegister() {
    context.go("/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter!"),
        backgroundColor: pink,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello scaffold"),
              icon: const Icon(
                Icons.mail,
                color: Colors.white54,
              )),
          IconButton(
              onPressed: () => debugPrint("Hello scaffold sms"),
              icon: const Icon(Icons.sms))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pink_bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "login".toUpperCase(),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Welcome back".toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(
              height: 45,
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              onChanged: (value) => {_onEmailChanged(value)},
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.white),
                labelStyle: const TextStyle(color: Colors.white),
                errorText: _emailError.isEmpty ? null : _passwordError,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              onChanged: (value) => {_onPasswordChanged(value)},
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.white),
                labelStyle: const TextStyle(color: Colors.white),
                errorText: _passwordError.isEmpty ? null : _emailError,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            ElevatedButton(
              onPressed: () => _onClickLogin(),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                "LOG IN",
                style: TextStyle(color: pink),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  _goToRegister();
                },
                child: Text("Create a new account".toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white)))
          ]
              .map((widget) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: widget,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
