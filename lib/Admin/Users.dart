import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Styles.dart';
import '../models/profile_model.dart';
// import 'AdminHome.dart';
// import 'dart:io';
import 'CustomerList.dart';

class Users extends StatefulWidget {
  Users({Key? key, required this.isCustomers}) : super(key: key);
  bool isCustomers;
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<ProfileModel> _CustomersList = [];

  @override
  void initState() {
    // TODO: implement initState
    bool isCustomers = widget.isCustomers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.blue_base,
        title: Text(widget.isCustomers ? 'Customers' : "Owners"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              child: FutureBuilder(
                future: widget.isCustomers
                    ? _fireStore.collection("Customer").get()
                    : _fireStore.collection("Gym Owner").get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    _CustomersList.clear();
                    snapshot.data.docs.forEach((element) {
                      _CustomersList.add(ProfileModel.fromJson(
                          element.data(), element.reference.id.toString()));
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            controller:
                                ScrollController(keepScrollOffset: true),
                            shrinkWrap: true,
                            itemCount: _CustomersList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // bool? isban = _CustomersList[index].isban;
                              return CustomerList(
                                  // gymInfo: _gymsList[index],
                                  // uid: '',
                                  // banuser: isban!,
                                  isCustomer: widget.isCustomers,
                                  user: _CustomersList[index]);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 5),
                          )
                        ],
                      ),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
