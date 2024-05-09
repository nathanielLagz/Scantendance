import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/Splashscreen/myhomepage.dart';

void main() => runApp(MyApp()); /* WidgetsFlutterBinding.ensureInitialized(); */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Scantendance',
      theme: ThemeData
      (
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}
