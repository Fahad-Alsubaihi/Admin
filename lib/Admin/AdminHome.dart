import 'package:Admin/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Admin/AddAdmin.dart';
import '../Admin/AllGyms.dart';
import '../Admin/Users.dart';
import '../Styles.dart';
//import 'package:gymhome/widgets/newhome.dart';
import 'package:path/path.dart';

import '../models/GymModel.dart';
import '../models/placeloc.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          break;
        case 'Add Admin':
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddAdmin()));
          break;
      }
    }

    //

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Admin ',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: colors.blue_base,
          elevation: 0,
          actions: <Widget>[
            // PopupMenuButton<String>(
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.black,
            //   ),
            //   onSelected: handleClick,
            //   itemBuilder: (BuildContext context) {
            //     return {'Logout', 'Add Admin'}.map((String choice) {
            //       return PopupMenuItem<String>(
            //         value: choice,
            //         child: Text(choice),
            //       );
            //     }).toList();
            //   },
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 250, 0),
                      child: Text(
                        'Hi Admin..',
                        style: TextStyle(
                            color: colors.blue_base,
                            fontFamily: 'Epilogue',
                            fontStyle: FontStyle.italic,
                            fontSize: 30),
                      )),
                  // Container(
                  //   margin: EdgeInsets.only(left: 300),
                  //   height: 150,
                  //   width: 150,
                  //   child: ElevatedButton(
                  //     onPressed: () {

                  //       FirebaseFirestore.instance
                  //           .collection('gyms')
                  //           .where('isWaiting', isEqualTo: false)
                  //           .get()
                  //           .then((value) {
                  //         value.docs.forEach((element) {
                  //           Review.setRateToGym(element.reference.id);
                  //         });
                  //       });
                  //     },
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Refresh',
                  //           style: TextStyle(fontSize: 30),
                  //         ),
                  //       ],
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       side: BorderSide(
                  //         width: 7,
                  //         color: Color.fromARGB(255, 170, 141, 62),
                  //       ),

                  //       shape: CircleBorder(),
                  //       padding: EdgeInsets.all(20),
                  //       primary: Colors.white, // <-- Button color
                  //       onPrimary: Color.fromARGB(
                  //           255, 170, 141, 62), // <-- Splash color
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 250),
                    height: 300,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        bool? isNew = true;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AllGyms(
                              isNew: isNew,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Waiting Gyms',
                            style: TextStyle(
                                fontSize:
                                    40 * MediaQuery.textScaleFactorOf(context)),
                          ),
                          // Text(
                          //   '500 ',
                          //   style: TextStyle(fontSize: 40),
                          // ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 7,
                          color: colors.blue_base,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.white, // <-- Button color
                        onPrimary: colors.blue_base, // <-- Splash color
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 300),
                    height: 200,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Users(isCustomers: false)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Owners ',
                            style: TextStyle(fontSize: 40),
                          ),
                          // Text(
                          //   '500 ',
                          //   style: TextStyle(fontSize: 40),
                          // ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 7,
                          color: Colors.pink,
                        ),

                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.white, // <-- Button color
                        onPrimary: Colors.pink, // <-- Splash color
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 250),
                    height: 250,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        bool? isNew = false;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllGyms(isNew: isNew)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Accepted Gyms',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Text(
                          //   '500 ',
                          //   style: TextStyle(fontSize: 40),
                          // ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 7,
                          color: Colors.orange,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.white, // <-- Button color
                        onPrimary: Colors.orange, // <-- Splash color
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 300),
                    height: 240,
                    width: 240,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Users(isCustomers: true)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Customers',
                            style: TextStyle(fontSize: 40),
                          ),
                          // Text(
                          //   '500 ',
                          //   style: TextStyle(fontSize: 40),
                          // ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 7,
                          color: Color.fromARGB(255, 62, 170, 105),
                        ),

                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.white, // <-- Button color
                        onPrimary: Color.fromARGB(
                            255, 62, 170, 105), // <-- Splash color
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              )
            ],
          ),
        ));
  }
}
