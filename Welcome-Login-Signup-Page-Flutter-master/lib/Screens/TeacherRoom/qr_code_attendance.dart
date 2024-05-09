import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatelessWidget{
  final String dbName;
  final String subjectCode;

  QrCodeGenerator(
    this.dbName,
    this.subjectCode,
  );

  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(today);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Qr Code"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              QrImage(
                data: dbName + ' ' + subjectCode + ' ' + DateTime.now().toString(),
                version: QrVersions.auto,
                backgroundColor: Colors.white,
                size: 200.0,
              ),
            ]
          )
        ),
      )
    );
  }
}