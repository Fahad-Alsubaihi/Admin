import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:html';
import 'dart:ui' as ui;

import '../models/GymModel.dart';

import 'package:flutter/material.dart';
import '../Styles.dart';

import 'package:geolocator/geolocator.dart';

class PlaceLocation extends StatefulWidget {
  GymModel gym;

  PlaceLocation({
    Key? key,
    required this.gym,
  }) : super(key: key);
  @override
  _PlaceLocationState createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  String? name;
  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.gym.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return Scaffold(
      body: getMap(),
    );
  }

  Widget getMap() {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      LatLng myLatlng =
          LatLng(widget.gym.location!.latitude, widget.gym.location!.longitude);
      // LatLng(24.633963, 46.807251);

      MapOptions mapOptions = MapOptions()
        ..zoom = 15
        ..center = myLatlng;

      DivElement elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      GMap map = GMap(elem, mapOptions);

      var image = widget.gym.gender == 'Men'
          ? 'assets/images/men_marker30.png'
          : 'assets/images/woman_marker30.png';

      Marker(MarkerOptions()
        ..icon = image
        ..position = myLatlng
        ..map = map
        ..title = name!);

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
