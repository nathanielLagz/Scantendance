import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/color.dart';
import 'data/data.dart';
import 'qr_scan_page.dart';

class DetailsPage extends StatelessWidget {
  final String idNum;
  final Item item;
  const DetailsPage({Key key, /*required*/ @required this.item, this.idNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height / 2.2,
            child: Image.asset(
              item.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 2.4),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20.0),
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(item.teacher,
                  style: TextStyle(color: grey, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40.0),
                Text(
                  item.summary,
                  style: TextStyle(color: grey, fontWeight: FontWeight.w400),
                ),
                Divider(
                  thickness: 2.5,
                  height: 40.0,
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  QRViewExample(idNum: this.idNum)),
          );
        },
        label: const Text('Scan Attendance'),
        icon: Icon(Icons.qr_code_scanner_sharp),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget tagButton({
    @required String image,
    @required String text,
    @required String value,
  }) {
    return Column(
      children: [
        CircleAvatar(
          child: SvgPicture.asset(
            'assets/icons/$image',
            color: blueColor,
            height: 20.0,
          ),
          backgroundColor: blueColor.withOpacity(0.2),
        ),
        Text(text, style: TextStyle(color: blueColor.withOpacity(0.6), fontWeight: FontWeight.w400)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }
}
