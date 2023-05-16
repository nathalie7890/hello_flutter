import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/model/user.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({Key? key}) : super(key: key);

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  final repo = UserRepoImpl();
  File? image;
  String base64ImageString = "";
  User? _user;

  @override
  void initState() {
    super.initState();

    fetchUser();
  }

  Future fetchUser() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final temp = await repo.getUserByEmail(user.email);
      setState(() {
        _user = temp;
      });
    }
  }

  Future safePic() async {
    if (_user != null && image != null) {
      final bytes = image!.readAsBytesSync();
      await repo.updateProfilePic(_user!.id, bytes);
    }
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);

      setState(() {
        this.image = imageFile;
      });
    }
  }

  _onClickLakes(context) {
    GoRouter.of(context).push("/switzerland");
  }

  _onClickRamen(context) {
    GoRouter.of(context).push("/ramen");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        color: Colors.purple.shade100,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => _onClickLakes(context),
                child: const Text("Lakes")),
            ElevatedButton(
                onPressed: () => _onClickRamen(context),
                child: const Text("Ramen")),
            ElevatedButton(
                onPressed: () => {_pickImage()},
                child: const Text("Pick image")),
            Container(
                child: image != null
                    // ? Image.memory(user!.image!)
                    ? Image.file(image!)
                    : _user?.image != null
                        ? Image.memory(_user!.image!)
                        : Container()),
            ElevatedButton(
                onPressed: () => safePic(), child: const Text("Save"))
          ],
        ));
  }
}
