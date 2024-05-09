import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/Login/login_student.dart';
import 'package:flutter_scantendance/Screens/Login/login_teacher.dart';
import 'package:flutter_scantendance/components/rounded_button.dart';
import 'package:flutter_scantendance/components/constants.dart';

// Intro Screen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(child: Image.asset('assets/icons/login2.png')),
            SizedBox(height: size.height * 0.05),
            Text(
              "WHO YOU ARE?",
              style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50),
            ),
            SizedBox(height: size.height * 0.02),
            RoundedButton(
              text: "Student",
              press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginStudent() ))
            ),
            RoundedButton(
              text: "Teacher",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTeacher() ))
            ),
          ],
        )
      ),
    );
  }
}