import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/StudentRoom/home_page.dart';
import 'package:flutter_scantendance/components/rounded_button.dart';
import 'package:flutter_scantendance/components/rounded_input_field.dart';
import 'package:flutter_scantendance/components/services_sql.dart';

class LoginStudent extends StatelessWidget {
  
  final TextEditingController studentIDcontroller = TextEditingController();

  LoginStudent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.15),
            Text(
              "STUDENT LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              child: Image.asset('assets/icons/log-in.png'),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Student ID",
              textController: studentIDcontroller,
              icon: Icons.person,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                // TODO
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomePage(idNum: studentIDcontroller.text)));
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
