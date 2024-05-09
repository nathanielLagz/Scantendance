import 'package:flutter/material.dart';
import 'package:flutter_scantendance/components/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool signupPage;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.signupPage = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          signupPage ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            signupPage ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05)
      ],
    );
  }
}
