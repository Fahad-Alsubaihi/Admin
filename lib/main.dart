import '../Admin/GymModel.dart';
import 'package:Admin/models/placeloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Styles.dart';

import '../Admin/AdminHome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GymModel g = GymModel([], [], [], 0, 0, 0, 0, 0, '', 'gymId', 'ownerId',
        'name', 'description', null, false, false, 'gender', 0, 0);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            // primarySwatch: colors.blue_base,
            ),
        home: AdminHome());
  }
}
