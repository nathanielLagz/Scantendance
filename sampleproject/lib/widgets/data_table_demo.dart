import 'package:flutter/material.dart';
import 'package:sampleproject/widgets/services.dart';
import 'package:sampleproject/widgets/student.dart';
import 'package:sampleproject/widgets/qr_room.dart';

class DataTableDemo extends StatefulWidget {
  final title = 'Teacher';
  const DataTableDemo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Student>? students;
  GlobalKey<ScaffoldState>? scafoldKey;
  TextEditingController? subjectCodeController;
  
  Student? selectedStudent;
  late bool isupdating;
  String? titleProgress;
  late String subjectCode;
  static const error = "Error. Please enter correct input.";

  @override
  void initState() {
    super.initState();
    students = [];
    isupdating = false;
    titleProgress = widget.title;
    scafoldKey = GlobalKey(); //getting key
    subjectCodeController = TextEditingController();
  }

  // For updating text on the appBar title
  showProgress(String message) {
    setState(() {
      titleProgress = message;
    });
  }

  showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
  }

  createRoom(String course, BuildContext context) {
    showProgress("Creating Room...");
    Services.createRoom(course).then((result) {
      if(result == 'success'){
        showSnackBar(context, 
        "Room ${subjectCodeController!.text.toUpperCase()} created");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => qrRoom(subjectCode: course))
          );
      }
      else {
        showSnackBar(context, error);
      }
      showProgress(widget.title);
    });
  }

  getStudent() {

  }

  updateStudent() {

  }

  deleteStudent() {

  }

  // For clearing textfield values
  clearValues() {
    subjectCodeController!.text = '';
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text(titleProgress!),
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          //Creating QR Room
          IconButton( 
            onPressed: () {
              createRoom(subjectCodeController!.text, context);
              // clearValues();
            },
            icon: const Icon(Icons.open_in_new),
            tooltip: "Create Room",
          ),
          // Adding student
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: getStudent,
            ),
        ],
      ),
      body: Container(   
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              //Subject Code
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: subjectCodeController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Subject Code',
                ),
              ),
            ),
            //Update button and cancel button
            isupdating?
            Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: updateStudent,
                  child: const Text('UPDATE')
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isupdating = false;
                    });
                    clearValues();
                  },
                  child: const Text('CANCEL')
                )
              ],
            )
            : Container()
          ],
        )
      ),
    );
  }
}