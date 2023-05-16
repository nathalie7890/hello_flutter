import "dart:ffi";

import "../model/person.dart";

abstract class PersonsRepo {
  List<Person> getPersons();
  bool addPerson(Person person);
  bool deletePerson(int id);

  }
