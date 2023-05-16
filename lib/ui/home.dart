import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/home_tabs/tab1.dart';
import 'package:hello_flutter/ui/home_tabs/tab2.dart';
import 'package:hello_flutter/ui/home_tabs/tab3.dart';
import "package:hello_flutter/colors.dart";
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final repo = UserRepoImpl();
  var user = User(name: "", email: "", password: "");
  // late User _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Widget _tabBarItem(String s, IconData icon) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), Text(s)],
      ),
    );
  }

  void _getUser() async {
    var res = await AuthService.getUser();
    var temp = await repo.getUserByEmail(res!.email);

    user = temp!;
    setState(() {});

    // if (res != null) {
    //   setState(() {
    //     user = res;
    //   });
    // }
  }

  void _logout(BuildContext context) {
    AuthService.deauthenticate();
    context.go("/login");
  }

  void _navigateToProfile(BuildContext context) {
    context.push("/profile");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: pink,
            bottom: const TabBar(
              tabs: [
                Icon(Icons.home),
                Icon(Icons.settings),
                Icon(Icons.person)
              ],
            ),
          ),
          body: const TabBarView(
            children: [FirstTab(), SecondTab(), ThirdTab()],
          ),
          bottomNavigationBar: Material(
            color: pink,
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 15),
              indicatorColor: Colors.transparent,
              // labelColor: Colors.white,
              // unselectedLabelColor: Colors.grey,
              indicatorPadding: const EdgeInsets.symmetric(vertical: -10),
              tabs: [
                _tabBarItem("Home", Icons.home),
                _tabBarItem("Settings", Icons.settings),
                _tabBarItem("Person", Icons.person)
              ],
            ),
          ),
          drawer: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(color: light_pink),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _navigateToProfile(context);
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: user.image != null
                                        ? Image.memory(user.image!).image
                                        : const AssetImage(
                                            "assets/images/teresa_palmer.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.name,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15),
                        )
                      ],
                    )),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        context.go("/switzerland");
                      },
                      title: const Text(
                        "Lakes",
                        style: TextStyle(color: pink),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.go("/ramen");
                      },
                      title: const Text(
                        "Ramen",
                        style: TextStyle(color: pink),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        _logout(context);
                      },
                      title: const Text(
                        "Logout",
                        style: TextStyle(color: pink),
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
