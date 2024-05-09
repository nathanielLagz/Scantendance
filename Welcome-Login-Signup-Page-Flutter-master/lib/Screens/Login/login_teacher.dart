import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/Signup/signup_screen.dart';
import 'package:flutter_scantendance/Screens/TeacherRoom/teacher_main_screen.dart';
import 'package:flutter_scantendance/components/already_have_an_account_acheck.dart';
import 'package:flutter_scantendance/components/rounded_button.dart';
import 'package:flutter_scantendance/components/rounded_input_field.dart';
import 'package:flutter_scantendance/components/rounded_password_field.dart';
import 'package:flutter_scantendance/components/services_sql.dart';


class LoginTeacher extends StatelessWidget {

  final TextEditingController firstName = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            SizedBox(height: size.height * 0.1),
            Text(
              "TEACHER LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            SizedBox(child: Image.asset('assets/icons/teacher2.png')),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(hintText: "First Name", icon: Icons.email ,textController: firstName),
            RoundedPasswordField(textController: passwordText),
            RoundedButton(
              text: "LOGIN",
              press: () {
                // TODO: EDITED
                Services.signInTeacher(firstName.text, passwordText.text).then((result) {
                  if(result == "Yes") {
                    showSnackBar(context, "Login Sucessfully");
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => TeacherRoom(username: firstName.text)));
                  }
                  else
                    showSnackBar(context, "Invalid username/password");
                });
              }
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen() ))
            )
          ],
        ),
      ),
    );
  }
}
