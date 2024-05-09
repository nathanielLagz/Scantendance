// CRUD functions on NoSQL database

import 'package:firebase_database/firebase_database.dart';

class Services {
  
  // static DatabaseReference reference = FirebaseDatabase.instance.reference();
  static DatabaseReference reference = FirebaseDatabase(
    databaseURL: 'https://scantendance-e6cc2-default-rtdb.asia-southeast1.firebasedatabase.app').reference();

  static Future<String> SignUp(String firstName, String lastName, String email, String password) async {
    Map<String, dynamic> object = {
      "firstName": firstName,
      "lastName" : lastName,
      "email": email,
      "Password": password
    };
    var id = reference.child('teachers/').push();
    id.set(object);
    
    return "success";
  }

  static Future<String> SignIn(String username, String password) async {
    DatabaseReference teacherRef = reference.reference().child('teachers');
    teacherRef.once().then((value) {
      print(value);
    });
    return "Yes";
  }
}