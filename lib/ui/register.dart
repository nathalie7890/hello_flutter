import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hello_flutter/colors.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _name = '';
  var _email = '';
  var _password = '';

  void _onChange(String value, String fieldName) {
    switch (fieldName) {
      case 'name':
        _name = value;
        break;
      case 'email':
        _email = value;
        break;
      case 'password':
        _password = value;
        break;
      default:
        break;
    }
  }

  File? image;
  String base64ImageString = "";

  Uint8List _getImageBytes() {
    return base64Decode(base64ImageString);
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      final bytes = imageFile.readAsBytesSync();
      final imageString = base64Encode(bytes);
      debugPrint(imageString);

      setState(() {
        this.image = imageFile;
        // this.base64ImageString = imageString;
      });
    }
  }

  void _onClickRegister() {
    AuthService.createUser(
        User(name: _name, email: _email, password: _password, image: null));
    context.go("/login");
  }

  _goToLogin() {
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: image != null
                          ? Image.memory(_getImageBytes()).image
                          : const AssetImage(
                              'assets/images/profile_pic_placeholder.jpg'),
                      fit: BoxFit.cover,
                    )),
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Register".toUpperCase(),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Sign up for a new account".toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) => {_onChange(value, "name")},
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: const TextStyle(color: Colors.white),
                labelStyle: const TextStyle(color: Colors.white),
                errorText: _name.isEmpty ? null : "This field is required",
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
              onChanged: (value) => {_onChange(value, "email")},
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.white),
                labelStyle: const TextStyle(color: Colors.white),
                errorText: _email.isEmpty ? null : "This field is required",
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
              onChanged: (value) => {_onChange(value, "password")},
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.white),
                labelStyle: const TextStyle(color: Colors.white),
                errorText: _password.isEmpty ? null : "This field is required",
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
              onPressed: () => _onClickRegister(),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                "REGISTER",
                style: TextStyle(color: pink),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  _goToLogin();
                },
                child: Text("Already have an account?".toUpperCase(),
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
