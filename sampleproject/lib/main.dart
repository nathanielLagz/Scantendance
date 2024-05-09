import 'package:flutter/material.dart';
import 'Widgets/data_table_demo.dart';

void main() => runApp(const HomeApp());

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Scantendance",
      home: DataTableDemo(),
      color: Colors.orangeAccent,
    );
  }
}