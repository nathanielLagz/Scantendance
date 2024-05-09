import 'package:flutter/material.dart';
import 'core/color.dart';
import 'data/data.dart';
import 'details_page.dart';

class StudentHomePage extends StatefulWidget {
  final String idNum;
  const StudentHomePage({Key key, this.idNum}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int selectMenu = 0;
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 65.0,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 5.0,
            bottom: 5.0,
          ),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: grey),
            ),
            child: Image.asset('assets/icons/dote.png'),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text('Hello Student', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300)),
            SizedBox(height: 5.0),
            Text('Scan your attendance here.', style: TextStyle(fontSize: 22.0),
            ),
            SizedBox(height: 80.0),
            // Container(
            //   height: 40.0,
            //   child: ListView(
            //     physics: BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       for (int i = 0; i < menu.length; i++)
            //         GestureDetector(
            //           onTap: () {
            //             setState(() => selectMenu = i);
            //           },
            //           child: Container(
            //             margin: EdgeInsets.only(right: 15.0),
            //             child: Column(
            //               children: [
            //                 Text(
            //                   menu[i].name,
            //                   style: TextStyle(
            //                     color: selectMenu == i ? 
            //                       blueColor : grey,
            //                   ),
            //                 ),
            //                 CircleAvatar(
            //                   radius: 2,
            //                   backgroundColor: selectMenu == i ? 
            //                     blueColor : Colors.transparent,
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (itemBuilder, index) {
                    return GestureDetector(
                      onTap: () {
                        // TODO
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => DetailsPage(item: items[index], idNum: widget.idNum,),
                          ),
                        );
                      },
                      child: Container(
                        height: 350.0,
                        width: 220.0,
                        margin: EdgeInsets.only(right: 20.0, bottom: 20.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                items[index].image,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ]),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    items[index].title,
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    items[index].teacher,
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.star,
                                  //       color: Colors.orange,
                                  //       size: 15.0,
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }
}
