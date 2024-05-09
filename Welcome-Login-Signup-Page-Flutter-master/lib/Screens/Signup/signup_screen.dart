import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/TeacherRoom/teacher_main_screen.dart';
import 'package:flutter_scantendance/components/already_have_an_account_acheck.dart';
import 'package:flutter_scantendance/components/rounded_button.dart';
import 'package:flutter_scantendance/components/rounded_input_field.dart';
import 'package:flutter_scantendance/components/rounded_password_field.dart';
import 'package:flutter_scantendance/components/services_sql.dart';
// import 'package:flutter_scantendance/components/services_nosql.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController  firstNameText = TextEditingController();
  final TextEditingController  lastNameText = TextEditingController();
  final TextEditingController  emailText = TextEditingController();
  final TextEditingController  passwordText = TextEditingController();
  final TextEditingController confirmedPassText = TextEditingController();
  
  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            SizedBox(height: size.height * 0.1),
            Text(
              "TEACHER SIGNUP",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55, fontStyle: FontStyle.italic),
            ),
            SizedBox(child: Image.asset('assets/icons/teacher4.png')),
            RoundedInputField(hintText: "First Name", icon: Icons.person, textController: firstNameText),
            RoundedInputField(hintText: "Last Name", icon: Icons.person, textController: lastNameText),
            RoundedInputField(hintText: "Your Email", icon: Icons.email, textController: emailText),
            RoundedPasswordField(textController: passwordText, text: "Password"),
            RoundedPasswordField(textController: confirmedPassText, text: "Confirm Password"),
            RoundedButton
            (
              text: "SIGNUP",
              press: () 
              {
                // TODO: EDITED
                if(firstNameText.text != "" || lastNameText.text != "" ||
                emailText.text != "" || passwordText.text != "" || confirmedPassText != "") {
                  if(passwordText.text == confirmedPassText.text) {
                    Services.signUp(firstNameText.text, lastNameText.text, emailText.text, passwordText.text).then((result) {
                      if(result == "success") {
                        showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("SIGN UP"),
                            content: const Text("Successfully signed up"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => TeacherRoom(username: firstNameText.text))),
                                  child: const Text('OK')
                              )
                            ]
                          );
                        }
                      );
                      }
                  } ); 
                }
               else
                  showSnackBar(context, "Please fill up all fields");
                }
              }
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(signupPage: false, press: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
