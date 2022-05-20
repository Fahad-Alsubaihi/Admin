import 'dart:io';
import 'package:Admin/Admin/Contact.dart';

import '../models/profile_model.dart';
import 'package:flutter/material.dart';
import '../Styles.dart';
import '../models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';

import '../models/user.dart';

class CustomerList extends StatefulWidget {
  CustomerList({
    Key? key,
    required this.user,
    required this.isCustomer,
  }) : super(key: key);
  ProfileModel user;
  bool isCustomer;
  // bool banuser;
  // String uid;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool? banuser;
  // static final _functions = FirebaseFunctions.instance;
  @override
  void initState() {
    banuser = widget.user.isban;
    // final origin = Platform.isAndroid ? 'http://10.0.2.2:5001' : 'http://localhost:5001';
    // _functions.useFunctionsEmulator("localhost", 5001);
    super.initState();
  }

  banCustomer(String uid) async {
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(uid)
        .update({'isban': true});
    // final HttpsCallable callable = _functions.httpsCallable("disabledUser");
    // return callable.call(uid);
  }

  banOwner(String uid) async {
    FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(uid)
        .update({'isban': true}).whenComplete(() {
      var snapshot = FirebaseFirestore.instance
          .collection('gyms')s
          .where('ownerId', isEqualTo: uid)
          .snapshots();
      snapshot.forEach((element) {
        element.docs.forEach((element) {
          element.reference.delete();
        });
      });
    });
    // final HttpsCallable callable = _functions.httpsCallable("disabledUser");
    // return callable.call(uid);
  }

  unbanCustomer(String uid) async {
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(uid)
        .update({'isban': false});
    // final HttpsCallable callable = _functions.httpsCallable("enabledUser");
    // return callable.call(uid);
  }

  unbanOwner(String uid) async {
    FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(uid)
        .update({'isban': false});
    // final HttpsCallable callable = _functions.httpsCallable("enabledUser");
    // return callable.call(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: widget.user.userImage != null
                    ? ClipOval(
                        child: Image.network(
                          widget.user.userImage!,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 45,
                              backgroundColor: colors.blue_smooth,
                              child: Icon(
                                Icons.person,
                                size: 85,
                                color: colors.iconscolor,
                              ),
                            );
                          },
                        ),
                      )
                    : CircleAvatar(
                        radius: 45,
                        backgroundColor: colors.blue_smooth,
                        child: Icon(
                          Icons.person,
                          size: 85,
                          color: colors.iconscolor,
                        ),
                      ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Tooltip(
                      message: widget.user.userName,
                      child: Container(
                        //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: widget.user.userName!.length <= 10
                            ? Text(
                                widget.user.userName ?? '',
                                style: TextStyle(
                                    fontFamily: 'Epilouge',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(widget.user.userName!.replaceRange(
                                10, widget.user.userName!.length, '..')),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Tooltip(
                      message: widget.user.email,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: widget.user.email!.length <= 10
                            ? Text(widget.user.email ?? '')
                            : Text(widget.user.email!.replaceRange(
                                10, widget.user.email!.length, '..')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SendEmail(user: widget.user)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(
                    'Contact',
                    style: TextStyle(color: colors.blue_base),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    banuser = !banuser!;
                  });
                  if (banuser!) {
                    // print('Ban : ' + widget.user.uid!);
                    widget.isCustomer
                        ? banCustomer(widget.user.uid!)
                            .then((value) => AppUser.message(
                                context, true, 'Customer has been banded'))
                            .onError((error, stackTrace) => AppUser.message(
                                context, false, "error when Ban this Customer"))
                        : banOwner(widget.user.uid!)
                            .then((value) => AppUser.message(
                                context, true, " Owner has been banded"))
                            .onError((error, stackTrace) => AppUser.message(
                                context, false, "error when Ban this Owner"));
                  } else {
                    widget.isCustomer
                        ? unbanCustomer(widget.user.uid!)
                            .then((value) => AppUser.message(
                                context, true, 'Customer has been Unbanded'))
                            .onError((error, stackTrace) => AppUser.message(
                                context,
                                false,
                                "error when Unban this Customer"))
                        : unbanOwner(widget.user.uid!)
                            .then((value) => AppUser.message(
                                context, true, " Owner has been Unbanded"))
                            .onError((error, stackTrace) =>
                                AppUser.message(context, false, "error when Unban this Owner"));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(
                    banuser! ? 'Unban' : 'Ban',
                    style: TextStyle(
                        color: banuser! ? colors.green_base : colors.red_base),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
