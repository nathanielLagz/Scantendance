import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scantendance/Screens/TeacherRoom/teacher_main_screen.dart';
import 'package:flutter_scantendance/components/services_sql.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final String idNum;
  const QRViewExample({Key key, this.idNum}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String result;
  Barcode output;
  QRViewController controller;
  String id;
  bool finished = false;
  @override
  void initState() {
    super.initState();
    id = widget.idNum;
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera(); 
  }

  Future<bool> backbuttonPressed(BuildContext context) async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.orange,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * .8
                ),
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result == "success") ?
                Text('Attended class successfully') : Text('Scan the QR attendance'),
              ),
            )
          ],
        ),
      )
    );
  }

// TODO: Edit Scanning result and checking date
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(!finished){
        setState(() {
        List<String> list = scanData.code.split(' ');
        Services.updateStudentAttendance(list[0], list[1], id).then((output) {
          print(output);
           if(output == "success") {
             result = output;
           }
          }
        );
        setState(() {
          finished = true;  
        });
      });
      }
      
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}