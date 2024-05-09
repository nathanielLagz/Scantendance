// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sampleproject/widgets/services.dart';

class qrRoom extends StatefulWidget {
  final subjectCode;
  const qrRoom(
    {
       Key? key,
       @required this.subjectCode
    } 
  ) : super(key: key); 
  
  @override
  State<StatefulWidget> createState() => qrRoomState();
}

class qrRoomState extends State<qrRoom> {
  TextEditingController? idNumController;
  TextEditingController? courseController;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  GlobalKey<ScaffoldState>? scafoldKey;
  String? widgetName, subjCode;
  

  @override
  void initState(){
    super.initState();
    widgetName = "Add students";
    subjCode = widget.subjectCode.toString().toUpperCase();
    scafoldKey = GlobalKey();
    idNumController = TextEditingController();
    courseController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
}

//Functions
  showProgress(String message) {
    setState(() {
       widgetName = message;
    });
  }

  getProgress() {

  }

  showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
  }

  addStudent(String subject, String id, String firstName, String lastName, String course) {
    showProgress("Adding student...");
    Services.addStudent(subject, id, firstName, lastName, course).then((result) {
        if(result == 'success'){
        showSnackBar(context, "Student Added.");
      }
      else {
        showSnackBar(context, "Error adding");
      }
      showProgress(widget.subjectCode.toString().toUpperCase());
    });
  }

  clearValues() {
    courseController!.text = '';
    firstNameController!.text = '';
    lastNameController!. text = '';
    courseController!.text = '';
  }

  generateAttendance() {

  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text(widgetName!),
        backgroundColor: Colors.orangeAccent[400],
        actions: <Widget>[
            IconButton(
              onPressed: generateAttendance,
              icon: const Icon(Icons.qr_code_outlined),
              tooltip: "Create Attendance",
            ),
            IconButton(
            onPressed: () => getProgress,
            icon: const Icon(Icons.insert_chart_outlined_outlined),
            tooltip: "Get Student's Progress",
            )
        ],
      ),
      body: Container(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(height: 5, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: subjCode, style: const TextStyle(fontWeight: FontWeight.bold) )
                  ]
                )),
              ),
            Fields(idNumController!, "School ID"),
            Fields(firstNameController!, "First Name"),
            Fields(lastNameController!, "Last Name"),
            Fields(courseController!, "Course"),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addStudent(
          widget.subjectCode, idNumController!.text,
          firstNameController!.text, lastNameController!.text,
          courseController!.text);
          clearValues();
        },
        child: const Icon(Icons.add_circle_rounded),
      )
    );
  }
}

class Fields extends StatefulWidget {
  final TextEditingController textController;
  final String textHint;
  Fields(
    this.textController,
    this.textHint,
  );
  @override
  State<StatefulWidget> createState() => _fieldsState();
}

class _fieldsState extends State<Fields> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration.collapsed(
          hintText: widget.textHint),
      ), 
      );
  }
}