import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_scantendance/Screens/StudentRoom/data/data.dart';
import 'package:flutter_scantendance/Screens/TeacherRoom/qr_code_attendance.dart';
import 'package:flutter_scantendance/components/services_sql.dart';
import 'package:flutter_scantendance/components/student.dart';

class TeacherQrRoom extends StatefulWidget {
  final String userDBname;
  final String roomNum;

  TeacherQrRoom(
    this.userDBname,
    this.roomNum, 
    {Key key}
  ): super(key: key);

  @override
  State<StatefulWidget> createState() => TeacherQrRoomState();
}

class TeacherQrRoomState extends State<TeacherQrRoom> {
  TextEditingController idTextController = new TextEditingController();
  TextEditingController firstNameTextController = new TextEditingController();
  TextEditingController lastNameTextController = new TextEditingController();
  TextEditingController courseTextController = new TextEditingController();
  TextEditingController presentTextController = new TextEditingController();
  TextEditingController absentTextController = new TextEditingController();
  String subjCode, dbName;
  List<Student> students;
  List<Student> selectedStudents;
  bool isSelected = false;

  //Dummy data
  // List<Student> students = [
  //   Student(
  //     id: "12-1234-123",
  //     firstName: "John",
  //     lastName: "Cruz",
  //     course: "BSCPE",
  //     present: "10",
  //     absent: "0"
  //   ),
  //   Student(
  //     id: "11-2233-456",
  //     firstName: "Susan",
  //     lastName: "Montero",
  //     course: "BSCPE",
  //     present: "7",
  //     absent: "3"
  //   ),
  //   Student(
  //     id: "18-1232-333",
  //     firstName: "Sarah",
  //     lastName: "Ramos",
  //     course: "BSCPE",
  //     present: "2",
  //     absent: "8"
  //   ),
  // ];
  
  @override
  void initState() {
    super.initState();
    students= [];
    selectedStudents= [];
    subjCode = widget.roomNum.toString();
    dbName = widget.userDBname;
    getStudents();
  }

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), elevation: 2,));
  }

  void getStudents() {
    Services.getStudents(dbName, subjCode).then((list) {
      setState( () {
        students = list;
        }
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(subjCode, style: TextStyle(fontFamily: "Gotham"),), 
        centerTitle: true,
        actions: [
          !isSelected ? 
          IconButton(
          icon: Icon(Icons.add),
          tooltip: "Add Students",
          iconSize: 30,
          onPressed: () {
            showDialog(
              context: this.context, 
              builder: (BuildContext context) {
                // Add Student
                return alert_Dialog(
                  titleText: Text("Add New Student"),
                  idController: idTextController..clear(),
                  firstNameController: firstNameTextController..clear(),
                  lastNameController: lastNameTextController..clear(),
                  courseController: courseTextController..clear(),
                  lists: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: TextStyle(color: Colors.grey))),
                    TextButton(
                      onPressed: () {
                        Services.addStudent(dbName, subjCode, idTextController.text,
                            firstNameTextController.text, lastNameTextController.text, courseTextController.text);
                        students.add(Student(
                          firstName: firstNameTextController.text,
                          lastName: lastNameTextController.text,
                          course: courseTextController.text,
                          present: "0",
                          absent: "0")
                        );
                        idTextController.clear();
                        firstNameTextController.clear();
                        lastNameTextController.clear();
                        courseTextController.clear();
                        showSnackBar(context, "Student added successfully.");
                        getStudents();
                        Navigator.pop(context);
                      },
                      child: const Text('Add', style: TextStyle(color: Colors.green))
                    )
                  ]);
              }
            );
          },
        )
        : IconButton(
          onPressed: () =>
            showDialog(context: context,
            builder: (builder) =>
              AlertDialog(
                title: Text("DELETE", textScaleFactor: 1.2),
                content: Text("Are you sure you want to delete selected student/s?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: TextStyle(color: Colors.grey),)),
                  TextButton
                  (onPressed: () {
                    while(selectedStudents.isNotEmpty){
                      Services.deleteStudent(dbName, subjCode, selectedStudents.removeLast().key);
                      getStudents();
                    }
                    setState(() {
                      isSelected = false;
                    });
                    showSnackBar(context, "Selected students deleted successfully.");
                    Navigator.pop(context);
                  },
                  child: Text("DELETE"))
                ],
              )
            ),
          icon: Icon(Icons.delete_rounded))
        ],
      ),
      body: Stack(
        children: [
          Center(
            heightFactor: 3.0,
            child: Text("Students", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Gotham"))),
            SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(top: 50),
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: DataTable(
                sortColumnIndex: 0,
                // sortAscending: checked,
                columns: [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("First Name")),
                  DataColumn(label: Text("Last Name")),
                  DataColumn(label: Text("Course")),
                  DataColumn(label: Text("Present"), numeric: true),
                  DataColumn(label: Text("Absent "), numeric: true),
                  DataColumn(label: Text("Passed?"))
                ],
                rows: students.map((student) =>
                  DataRow(
                    selected: selectedStudents.contains(student),
                    onSelectChanged: (selected) {
                      setState(() {
                        isSelected = selected != null && selected;
                        isSelected? 
                          selectedStudents.add(student)
                        : selectedStudents.remove(student);
                      });
                      
                    },
                    cells: [
                      DataCell(Text(student.id),
                        // Update Student
                        onLongPress: () => showDialog(context: context,
                        builder: (BuildContext builder) {
                          return alert_Dialog(
                            idController: idTextController..text = student.id,
                            firstNameController: firstNameTextController..text = student.firstName,
                            lastNameController: lastNameTextController..text = student.lastName,
                            courseController: courseTextController..text = student.course,
                            presentController: presentTextController..text = student.present,
                            absentController: absentTextController..text = student.absent,
                            titleText: Text("Edit Student"),
                            lists: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel", style: TextStyle(color: Colors.grey),)),
                              TextButton(
                                onPressed: () {
                                Services.updateStudent(
                                  dbName, subjCode, idTextController.text,
                                  firstNameTextController.text, lastNameTextController.text , courseTextController.text,
                                  presentTextController.text, absentTextController.text, student.key);
                                showSnackBar(context, "Student updated successfully");
                                getStudents();
                                Navigator.pop(context);
                              },
                                child: Text("Save", style: TextStyle(color: Colors.green),))
                            ]
                          );
                        })
                      ),
                      DataCell(Text(student.firstName)),
                      DataCell(Text(student.lastName)),
                      DataCell(Text(student.course)),
                      DataCell(Text(student.present)),
                      DataCell(Text(student.absent)),
                      DataCell(
                        Center(
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [BoxShadow(spreadRadius: 7, color: Colors.black12.withOpacity(0.1))]),
                            child: student.computeGrade() >= .6 ? Icon(Icons.check_circle_outline, color: Colors.green,) : Icon(Icons.do_disturb_alt, color: Colors.red,)
                            ))
                          )
                  ])
                ).toList()
              ),
            )
          ] ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QrCodeGenerator(dbName, subjCode)));
        },
        tooltip: "Create Attendance",
        child: Icon(Icons.qr_code_2_sharp),
        ),
    );
  }
}


class alert_Dialog extends StatelessWidget {
  final Widget titleText;
  final TextEditingController idController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController courseController;
  TextEditingController presentController;
  TextEditingController absentController;
  final List<Widget> lists;
  bool editButton;

  alert_Dialog({
    @required this.titleText,
    @required this.idController,
    @required this.firstNameController,
    @required this.lastNameController,
    @required this.courseController,
    @required this.lists,
    this.presentController,
    this.absentController,
    this.editButton,
    Key key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(30),
      title: titleText,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: idController, decoration: InputDecoration(hintText: "ID" ) ),
          TextField( controller: firstNameController, decoration: InputDecoration(hintText: "First Name") ),
          TextField(controller: lastNameController, decoration: InputDecoration(hintText: "last Name") ),
          TextField(controller: courseController, decoration: InputDecoration(hintText: "Course") ),
          TextField(controller: presentController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "Presents")),
          TextField(controller: absentController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "Absents")),  
        ],
      ),
      actions: lists,
    );
  }
}