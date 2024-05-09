import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scantendance/Screens/TeacherRoom/teacher_qr_room.dart';
import 'package:flutter_scantendance/components/constants.dart';
import 'package:flutter_scantendance/components/services_sql.dart';


class TeacherRoom extends StatefulWidget {
  final String username;
  const TeacherRoom({@required this.username, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TeacherRoomState();
}

class TeacherRoomState extends State<TeacherRoom> {
  String userName;
  final TextEditingController subjectCodeText = TextEditingController();
  List<String> room;

  @override
  void initState() {
    super.initState();
    userName = widget.username;
    room = [];
    getAllClassroom();
  }

  void getAllClassroom() {
    setState(() {
      room = [];
      Services.getClassrooms(userName).then((items) {
      items.replaceAll(RegExp(r"[^\s\w]"), '').substring(19).toUpperCase();
      List<String> temp = items.split(",");
      for (var a in temp) {
        room.add(a.replaceAll(RegExp(r"[^\s\w]"), '').replaceAll("Tables_in_${userName.toLowerCase()}", '').toUpperCase());
      }
      });
    });
  }

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)) );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backButtonPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: kPrimaryLightColor,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Teacher's Room",
            style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned (
              left: 20,
              top: 230,
              child: Card(
                elevation: 2.0,
                child: Container(
                    child: Text("Rooms created:", style: TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.w600)),
                  decoration: BoxDecoration(color: Colors.black12),
                )
              )
            ),
            room.isNotEmpty ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 270, bottom: 15),
                  child: ListView.separated
                  (
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: room.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ListTile(
                          title: Center(child: Text("Room ${room[index]}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),)),
                          tileColor: Colors.orange[300],
                          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                          leading: Icon(Icons.domain_verification_outlined, size : 30),
                          trailing: IconButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                               builder: (context) => AlertDialog(
                                 title: Text("Delete Room", textScaleFactor: 1.5),
                                 content: Text("Are you sure you want to delete Room ${room[index]}? All records within this room will be deleted.",
                                  style: TextStyle(fontSize: 17),
                                 ),
                                 actions: [
                                   TextButton(
                                     onPressed: () => Navigator.pop(context),
                                     child: Text("Cancel", style: TextStyle(color: Colors.grey),)),
                                  //  Delete Room
                                   TextButton(
                                     onPressed: () {
                                       Services.deleteQRClassroom(room[index], userName);
                                       showSnackBar(context, "Room ${room[index]} deleted successfully");
                                       setState(() {
                                         room.remove(room[index]);
                                       });
                                       Navigator.pop(context);
                                     }, 
                                     child: Text("DELETE"),
                                   )
                                 ],
                               )
                              );
                            },
                            icon: Container(
                              decoration: BoxDecoration(color: Colors.deepOrange[300].withOpacity(0.6), border: Border.all(width: 0.2)),
                              child: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.black,
                                size: 25
                              )
                            ),
                          ),
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.elliptical(15,12)),
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherQrRoom(userName, room[index]))),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 20, thickness: 5.0 ,),
                    controller: ScrollController(keepScrollOffset: true),
                  ),
                ) : Center(child: Text("No rooms yet", style: TextStyle(fontSize: 15.0),)), 
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: Colors.orange,
              child: Container(
                width: MediaQuery.of(context).size.width * .905,
                height: MediaQuery.of(context).size.height * .30,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    SizedBox(
                      child:Icon(Icons.person, size: 60, color: Colors.grey) ,
                      width: 100,
                    ),
                    SizedBox(height: 30,),
                    Text("Welcome, ${userName.toUpperCase()} !",
                      style: TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.w900,
                        fontSize: 29.0),    
                    ),
                    SizedBox(height: 30,),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Subject Code", style: TextStyle(fontWeight: FontWeight.w700, fontFamily: "Gotham") ),
              content: TextField(controller: subjectCodeText..clear()), 
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: TextStyle(color: Colors.grey))),
                // Add Room
                TextButton(
                  onPressed: () {
                    Services.createQRClassroom(subjectCodeText.text, userName);
                    showSnackBar(context, "Room ${subjectCodeText.text} created");
                    getAllClassroom();
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherQrRoom(userName, subjectCodeText.text)));
                  },
                  child: Text("Create"), 
                )
              ],
            )),
          label: Text("Add Room"),
          icon: Icon(Icons.add),
          backgroundColor: kPrimaryColor,
        ),
      ),   
    );    
  }


  Future<bool> backButtonPressed() async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Log Out", style: const TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.w700) ),
        content: Text("Are you sure you want to log out?"),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Container(
              child: const Text("No",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.elliptical(7, 10))
              ),
            ),
          ),
          SizedBox(width: 2.0),
          GestureDetector(
            onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Container(
              child: const Text(
                "Yes",
                style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.elliptical(7, 10)),
              ),
              ),
          ),
        ],
      )
      ) ?? false;
  }
}