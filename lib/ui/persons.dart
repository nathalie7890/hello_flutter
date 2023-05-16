import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/colors.dart";
import 'package:hello_flutter/data/model/Person.dart';

class Persons extends StatefulWidget {
  const Persons({Key? key}) : super(key: key);

  @override
  State<Persons> createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  final _persons = [
    const Person(firstName: "Abc", lastName: "def", age: 20, title: "Student"),
    const Person(firstName: "Abc", lastName: "def", age: 20, title: "Student"),
    const Person(firstName: "Abc", lastName: "def", age: 20, title: "Student"),
    const Person(firstName: "Abc", lastName: "def", age: 20, title: "Student"),
  ];

  _onClickBack() {
    context.pop("Hello from persons. Back");
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
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: pink,
            child: ListView.builder(
                itemCount: _persons.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: light_pink),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/teresa_palmer.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${_persons[index].firstName} ${_persons[index].firstName}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text("Age: ${_persons[index].age}"),
                            Text("Title: ${_persons[index].title}"),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )),
          Container(
              width: double.infinity,
              color: pink,
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: pink, elevation: 0),
                  onPressed: _onClickBack,
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )))
        ],
      ),
    );
  }
}
