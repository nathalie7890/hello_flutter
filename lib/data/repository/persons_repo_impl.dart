import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/model/person.dart';
import 'package:hello_flutter/data/repository/persons_repo.dart';

class PersonsRepoImpl extends PersonsRepo {
  static final PersonsRepoImpl _instance = PersonsRepoImpl._internal();
  factory PersonsRepoImpl() {
    return _instance;
  }

  PersonsRepoImpl._internal();

  var counter = 2;
  final _persons = {
    1: const Person(
        id: 1, firstName: "abc", lastName: "def", title: "Student", age: 15),
    2: const Person(
        id: 1, firstName: "xyz", lastName: "def", title: "Student", age: 15),
  };


  @override
  bool addPerson(Person person) {
    debugPrint(person.firstName.toString());
    counter++;
    debugPrint(counter.toString());
    _persons[counter] = person.copy(id: counter);
    debugPrint(_persons.length.toString());
    return true;
  }

  @override
  bool deletePerson(int id) {
    return _persons.remove(id) != null;
  }

  @override
  List<Person> getPersons() {
    return _persons.entries.map((e) => e.value).toList();
  }
}
