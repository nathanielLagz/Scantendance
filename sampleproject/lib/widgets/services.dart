import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';

class Services {
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _SEARCH_ROOM = 'SEARCH_ROOM';
  static const _ADD_STUD_ACTION = 'ADD_STUD';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _UPDATE_STUD_ACTION = 'UPDATE_STUD';
  static const _DELETE_STUD_ACTION = 'DELETE_STUD';
  static final root = Uri.parse('http://192.168.1.2/scantendanceDB/scantendance_actions.php');


  
  //Going to Room
  static Future<String> createRoom(String course) async {
    try {
      //adding parameters to pass the request
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      map['table'] = course;
      final response = await http.post(root, body: map);
      if(response.statusCode == 200) {
        return response.body;
      }
      else {
        return "error";
      }
    }
    catch (e) {
      return "Error";

    }
  }

  static Future<List<Student>> getStudents() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(root, body: map);
      print('getStudents Response: ${response.body}');
      if(response.statusCode == 200) {
        List<Student> list = parseResponse(response.body);
        return list;
      }
      else {
        return <Student>[]; //empty list
      }
    }
    catch(e) {
      return <Student>[]; //empty list
    }
  }

  static List<Student> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json)=> Student.fromJson(json)).toList();
  }

  //add student
  static Future<String> addStudent (
    String subject, String id, String firstName, String lastName, String course) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_STUD_ACTION;
      map['table'] = subject;
      map['id'] = id;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['course'] = course;
      final response = await http.post(root, body: map);
      print('addStudent Response: ${response.body}');
      if(response.statusCode == 200) {
        // List<Student> list = parseResponse(response.body);
        return response.body;
      }
      else {
        return "error";
      }
    }
    catch(e) {
      return "error";
    }
  }

  //Method on updating a student to database
  static Future<String> updateStudent(
    int id, String firstName, String lastName, String course, int present, int absent) async{
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_STUD_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['course'] = course;
      map['present'] = present;
      map['absent'] = absent;
      final response = await http.post(root, body: map);
      print('addStudent Response: ${response.body}');
      if(response.statusCode == 200) {
        List<Student> list = parseResponse(response.body);
        return response.body;
      }
      else {
        return "error";
      }
    }
    catch(e) {
      return "error";
    }
  }

  //Method on deleting a student to database
  static Future<String> deleteStudent(int id) async{
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_STUD_ACTION;
      map['id'] = id;
      final response = await http.post(root, body: map);
      print('deleteStudent Response: ${response.body}');
      if(response.statusCode == 200) {
        List<Student> list = parseResponse(response.body);
        return response.body;
      }
      else {
        return "error";
      }
    }
    catch(e) {
      return "error";
    }
  }
}