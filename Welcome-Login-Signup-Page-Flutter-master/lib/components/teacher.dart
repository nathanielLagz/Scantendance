import 'package:flutter_scantendance/components/student.dart';

class Teacher {
  String/*!*/ firstName;
  String/*!*/ lastName;
  List rooms = [];

  Teacher(
    {
      this.firstName,
      this.lastName,
      this.rooms
    }
  );

   factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      firstName : json['firstName'] as String, 
      lastName: json['lastName'] as String,
    );
  }

}

class Rooms{
    
  }

