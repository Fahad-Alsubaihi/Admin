import 'package:Admin/Admin/GymDescription.dart';
import 'package:Admin/Styles.dart';
import 'package:flutter/material.dart';
import '../models/GymModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/profile_model.dart';

class GymCardAdmin extends StatefulWidget {
  const GymCardAdmin({
    Key? key,
    required this.gymInfo,
    required this.isNew,
  }) : super(key: key);
  final GymModel gymInfo;
  final bool isNew;

  @override
  State<GymCardAdmin> createState() => _GymCardAdminState();
}

class _GymCardAdminState extends State<GymCardAdmin> {
  ProfileModel _userProfile = ProfileModel('', '', '', '', false);
  Future getOwnerName() async {
    var data = await FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(widget.gymInfo.ownerId)
        .get();
    Map<String, dynamic> _owner = data.data() as Map<String, dynamic>;
    setState(() {
      name = _owner['name'];
      email = _owner['email'];
    });
  }

  Future<void> _getOwnerinfo() async {
    var _owner = await FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(widget.gymInfo.ownerId!)
        .get();
    Map<String, dynamic> own = await _owner.data() as Map<String, dynamic>;
    name = own['name'];
    email = own['email'];
  }

  String name = 'Name Here';
  String email = 'Email Here';
  @override
  void initState() {
    if (mounted) String gymid = widget.gymInfo.gymId!;
    // print('gymId : $gymid');
    _getOwnerinfo().whenComplete(() {
      setState(() {});
    });
    FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(widget.gymInfo.ownerId!)
        .get()
        .then((value) {
      setState(() {
        name = value.data()!['name'];
        email = value.data()!['email'];

        print('name : $name');
        print('email : $email');
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymDescrption(
                  gym: widget.gymInfo,
                  isNew: widget.isNew,
                )));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        //   width: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(0xff3d4343),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                offset: Offset(3, 3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        child: Column(
          children: [
            Expanded(
              // flex: 2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(widget.gymInfo.imageURL ?? '',
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(50))),
                      child: Text(
                        widget.gymInfo.name ?? '',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff48484a),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // Column(
                  //   children: [Text('Fahad')],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Row(
                        children: [
                          Text(
                            ' ' + widget.gymInfo.avg_rate.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Icon(
                            Icons.star,
                            size: 45,
                            color: colors.yellow_base,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // FutureBuilder(
                      //     future: _getdata(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<dynamic> snapshot) {
                      //       String name;
                      //       if (snapshot.hasData) {
                      //         Map<String, dynamic> _data =
                      //             snapshot.data.data() as Map<String, dynamic>;

                      //         // name = _data['name'];
                      //         _userProfile = ProfileModel.fromJson(
                      //             _data, snapshot.data.reference.id.toString());

                      //         return Text(_userProfile.email!);
                      //       }
                      //       return Text('wai');
                      //     }),
                      Text(email,
                          style: TextStyle(fontSize: 20, color: Colors.white)),

                      Text(
                        widget.gymInfo.reviews == 0
                            ? 'No reviews yet'
                            : "Based on " +
                                widget.gymInfo.reviews.toString() +
                                " reviews",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "50 Km",
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Icon(
                      //       Icons.directions_walk,
                      //       color: Colors.white,
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getname() {
    Future.delayed(Duration(seconds: 1), (() {
      return Text(email, style: TextStyle(fontSize: 20, color: Colors.white));
    }));
    return Center(child: CircularProgressIndicator());
  }
}
