import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/Welcome/welcome_screen.dart';
import 'package:lottie/lottie.dart';

// Splash Screen
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 3), () {
      //edited
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen() ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 200),
            SizedBox(
              height: 350,
              width: 350,
              child: Lottie.asset('assets/splashback.json')
            ),
            SizedBox(height: 20* 0.05),
            Text("Scantendance",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontFamily: 'Gotham', 
                fontSize: 50, 
                color: Color(0xFFB71C1C)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
