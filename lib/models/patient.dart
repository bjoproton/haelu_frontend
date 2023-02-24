import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Patient with ChangeNotifier
{
  // {
  //   "id": 1,
  //   "username": "patient1",
  //   "uuid": "1dd07f76-83e3-4dec-9ef6-87d0b3f492b1",
  //   "first_name": "John",
  //   "last_name": "Smith"
  // },

  final int id;
  final String uuid;
  final String firstName;
  final String lastName;

  Patient({
      required this.id,
      required this.uuid,
      required this.firstName,
      required this.lastName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      uuid: json['uuid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
