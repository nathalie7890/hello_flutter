import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import "package:hello_flutter/colors.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = const User(name: "", email: "", password: "");
  String base64ImageString = "";
  late Future<File> userImage;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  String email = "";
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getString('user');
    // var res = await AuthService.getUser();

    if (res != null) {
      var userData = User.fromMap(jsonDecode(res));
      setState(() {
        user = userData;
        _name.text = user.name;
        _email.text = user.email;
      });

      if (user.image != null) {
        setState(() {
          userImage = saveImage(user.image!);
        });
      }
    }
  }

  File? image;

  Future<File> saveImage(Uint8List imageBytes) async {
    final directory = Directory.systemTemp;
    final file = File('${directory.path}/image.png');
    await file.writeAsBytes(imageBytes);
    return file;
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      final bytes = imageFile.readAsBytesSync();
      final imageString = base64Encode(bytes);

      setState(() {
        this.image = imageFile;
        // this.base64ImageString = imageString;
      });
    }
  }

  _nameOnChange(value) {
    _name.text = value;
    _name.selection = TextSelection.collapsed(offset: _name.text.length);
  }

  _emailOnChange(value) {
    _email.text = value;
    _email.selection = TextSelection.collapsed(offset: _email.text.length);
  }

  Future _updateUser() async {
    if (_name.text.isNotEmpty && _email.text.isNotEmpty) {
      await AuthService.updateUser(
          user.copy(name: _name.text, email: _email.text));
      _getUser();
    }
  }

  _saveBtnOnClick() {
    _updateUser();
    isEditing = false;
  }

  _editBtnOnClick() {
    setState(() {
      isEditing = true;
    });
  }

  final _bio =
      "Quisque at lectus egestas mauris rutrum viverra. In nisl turpis, mollis sed diam a, blandit iaculis sem. Proin maximus sagittis risus et laoreet.";

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
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/teresa_palmer.jpg'),
                      fit: BoxFit.cover,
                    )),
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              user.name.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Vegan enthusiast | Yoga instructor",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.facebook,
                  color: light_pink,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.twitter,
                  color: light_pink,
                  size: 24.0,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.linkedin,
                  color: light_pink,
                  size: 24.0,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.instagram,
                  color: light_pink,
                  size: 24.0,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.youtube,
                  color: light_pink,
                  size: 24.0,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Posts",
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("72",
                              style: TextStyle(
                                  color: pink,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20))
                        ],
                      ),
                      Column(
                        children: [
                          Text("Followers",
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("361",
                              style: TextStyle(
                                  color: pink,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20))
                        ],
                      ),
                      Column(
                        children: [
                          Text("Following",
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("127",
                              style: TextStyle(
                                  color: pink,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20))
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                    height: 30,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bio",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(_bio,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ))
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                    height: 40,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.grey.shade700,
                            size: 15.0,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            "038-994-349",
                            style: TextStyle(
                                color: pink, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.grey.shade700,
                            size: 15.0,
                          ),
                          const SizedBox(width: 15),
                          // TextField(
                          //          controller: _email,
                          //          onChanged: (value) => _emailOnChange(value),
                          //          style: const TextStyle(color: pink),
                          //          decoration: InputDecoration(
                          //              border: OutlineInputBorder(
                          //                  borderRadius:
                          //                      BorderRadius.circular(8.0),
                          //                  borderSide: const BorderSide(
                          //                      color: Colors.black45,
                          //                      width: 2.0)),
                          //              hintText: "Email",
                          //              hintStyle: const TextStyle(color: pink)),
                          //        )
                          Text(
                            user.email,
                            style: const TextStyle(
                                color: pink, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _editBtnOnClick();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: pink),
                          )),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () {
                            _saveBtnOnClick();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
