import 'package:flutter/material.dart';
import 'package:google_map/custom_marker_info_window.dart';
import 'package:google_map/map_screen.dart';
import 'package:google_map/networkImageCustomMarker.dart';
import 'package:google_map/proofOfConcept1.dart';
import 'package:google_map/proofOfConcept2.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NetworkImageCustomMarker3(),
    );
  }
}
