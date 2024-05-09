// CRUD Functions on SQL database

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';

class Services {
  static const _SIGN_UP_ACTION = 'SIGN_UP';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ROOM_ACTION = 'GET_ROOM';
  static const _DELETE_ROOM_ACTION = 'DELETE_ROOM';
  static const _ADD_STUD_ACTION = 'ADD_STUD';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _UPDATE_STUD_ACTION = 'UPDATE_STUD';
  static const _DELETE_STUD_ACTION = 'DELETE_STUD';
  static const _UPDATE_STUD_ATTENDANCE_ACTION = 'UPDATE_STUD_ATTENDANCE';
  // Changing into local IP address to connect phpmyadmin quickly (http://localhost/EmployeesDB/employee_actions.php')
  static final root = Uri.parse('http://192.168.1.2/scantendanceDB/scantendance_actions.php');

  // Parsing into list from database
  static List<Student> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }

  static Future<String> signUp(String firstName, String lastName, String email, String password) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = "users";
      map['table'] = "teacher";
      map['action'] = _SIGN_UP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['email'] = email;
      map['password'] = password;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200)
        return response.body;
      else
        return "error";
    }
    catch (e) {
      return "Error";
    }
  }

  static Future<String> getClassrooms(String dbname) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = dbname;
      map['table'] = "";
      map['action'] = _GET_ROOM_ACTION;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200) 
        return response.body;
      else 
        return "error";
    }
    catch (e) {
      return "Error";
    }
  }

  static Future<String> signInTeacher(String username, String password) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = "users";
      map['table'] = "teacher";
      map['action'] = "SIGN_IN";
      map['first_name'] = username;
      map['passcode'] = password;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200)
        return response.body;
      else 
        return "error";
    }
    catch (e) {
      return "Error";
    }
  }

  static Future<String> createQRClassroom(String course, String username) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      map['table'] = course;
      map['dbname'] = username;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200)
        return response.body;
      else 
        return "error";
    }
    catch (e) {
      return "Error";
    }
  }

  static Future<String> deleteQRClassroom(String course, String username) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_ROOM_ACTION;
      map['table'] = course;
      map['dbname'] = username;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200)
        return response.body;
      else 
        return "error";
    }
    catch (e) {
      return "Error";
    }
  }


  static Future<List<Student>> getStudents(String username, String subjectCode) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = username;
      map['table'] = subjectCode.toLowerCase();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200) {
        List<Student> list = parseResponse(response.body);
        return list;
      }
      else
        return <Student>[]; //empty list
    }
    catch(e) {
      return <Student>[]; //empty list
    }
  }

  static Future<String> addStudent(String dbname, String subject, String id, String firstName, String lastName, String course) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_STUD_ACTION;
      map['dbname'] = dbname;
      map['table'] = subject;
      map['id'] = id;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['course'] = course;
      final response = await http.post(root, body: map);
      print('addStudent Response: ${response.body}');
      if(response.statusCode == 200){
        return response.body;
      }
      else 
        return "error";
    }
    catch(e) {
      return "error";
    }
  }

  static Future<String> updateStudent(
    String dbname, String subject,
    String id, String firstName, String lastName, String course,
    String present, String absent, String key) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = dbname;
      map['table'] = subject.toLowerCase();
      map['action'] = _UPDATE_STUD_ACTION;
      map['key'] = key;
      map['id'] = id;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['course'] = course;
      map['presents'] = present;
      map['absents'] = absent;
      final response = await http.post(root, body: map);
      print('Attendance Response: ${response.body}');
      if(response.statusCode == 200){
        return response.body;
      }
      else 
        return "error";
    }
    catch(e) {
      return "error";
    }
  }

  //TODO
  static Future<String> deleteStudent(String dbName, String subject, String id) async{
    try {
      var map = <String, dynamic>{};
      map['dbname'] = dbName;
      map['table'] = subject.toLowerCase();
      map['action'] = _DELETE_STUD_ACTION;
      map['id'] = id;
      final response = await http.post(root, body: map);
      print('deleteStudent Response: ${response.body}');
      if(response.statusCode == 200) {
        // List<Student> list = parseResponse(response.body);
        return response.body;
      }
      else
        return "error";
    }
    catch(e) {
      return "error";
    }
  }

  // TODO
  static Future<String> updateStudentAttendance(String dbName, String subj, String id) async {
    try {
      var map = <String, dynamic>{};
      map['dbname'] = dbName;
      map['table'] = subj.toLowerCase();
      map['action'] = _UPDATE_STUD_ATTENDANCE_ACTION;
      map['id'] = id;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200){
        return response.body;
      }
      else
        return "error";
    } catch (e) {
      return "error";
    }
    
  }
}