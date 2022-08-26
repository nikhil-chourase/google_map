import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  Completer<GoogleMapController> _controller = Completer();
  
  static final CameraPosition _cameraPosition = CameraPosition(target: LatLng(37.3304, -121.7922),zoom: 12);



  List<Marker> _marker = [];


  List<Marker> _list = [
    Marker(
      markerId: MarkerId('my position'),
      position: LatLng(37.3304, -121.7922),
      infoWindow: InfoWindow(
        title: 'my position'
      ),
    ),

  ];

  Future<Position> getUserLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print(error);
    });


    return await Geolocator.getCurrentPosition();


  }


  showUserLocation() async{
    getUserLocation().then((value) async{
      _marker.add(
        Marker(
          markerId: MarkerId('my position'),
          position: LatLng(value.latitude,value.longitude),
          infoWindow: InfoWindow(
            title: 'my position',
          ),
        ),
      );
      final GoogleMapController controller = await _controller.future;




      setState((){
        CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 12);


        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      });
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    getUserLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        compassEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
      ),

    );
  }
}
