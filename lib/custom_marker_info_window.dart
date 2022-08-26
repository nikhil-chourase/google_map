import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_map/card_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:async';




class CustomMarkerInfoWindow extends StatefulWidget {

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {


  void showAlertDailog(){
    showDialog(
        context: context,
        builder: (context){
          return BackdropFilter(
            
              filter: ImageFilter.blur(),
              child: AlertDialog());
        }
    );
  }


  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();



  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = [
    LatLng(37.3834, -121.9024),LatLng(37.5771, -122.0169),
    LatLng(37.7130, -121.9033),LatLng(38.5503, -121.4499),
    LatLng(37.7742, -121.5257),LatLng(37.9639, -121.7393),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  Future<Uint8List?> loadNetworkImage(String path) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) {
          completer.complete(info);

        })
    );

    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();

  }


  loadData() async{
    for(int i=0;i<_latlng.length;i++){
      Uint8List? image = await loadNetworkImage('https://cdn.pixabay.com/photo/2016/11/22/11/48/cup-1849083_960_720.png');

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 200,
        targetWidth: 200,
      );


      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();

      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          position: _latlng[i],
          onTap: (){

            customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://drive.google.com/uc?export=view&id=1rhB4ZdzqdgKAXzMpokqXmVd4j2_eTT11'),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    // list


                  ],
                ),
              ),
              _latlng[i]
            );
          },
        ),

      );

      setState((){

      });
      
      //showAlertDailog();
    }

  }
  @override
  Widget build(BuildContext context) {

    bool isVisible = false;



    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
            target: LatLng(37.3304, -121.7922),
              zoom: 9,
            ),
            markers: Set<Marker>.of(_markers),
            onTap: (position){
              customInfoWindowController.hideInfoWindow!();

              setState((){


              });

              //showAlertDailog();




            },
            onMapCreated: ( controller){
              customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 107,
            width: 200,
            offset: 35,

          ),
          Visibility(
            visible: isVisible,
            child: Container(
              child: ListView(
                children: [
                  CarouselSlider(
                    items: [

                      //1st Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage('https://drive.google.com/uc?export=view&id=1rhB4ZdzqdgKAXzMpokqXmVd4j2_eTT11'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //2nd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage('https://images.pexels.com/photos/3023479/pexels-photo-3023479.jpeg?auto=compress&cs=tinysrgb&w=600'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //3rd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage('https://images.pexels.com/photos/89731/pexels-photo-89731.jpeg?auto=compress&cs=tinysrgb&w=600'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //4th Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage('https://images.pexels.com/photos/298217/pexels-photo-298217.jpeg?auto=compress&cs=tinysrgb&w=600'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //5th Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage('https://images.pexels.com/photos/7645874/pexels-photo-7645874.jpeg?auto=compress&cs=tinysrgb&w=600'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],


                    //Slider Container properties
                    options: CarouselOptions(
                      height: 100.0,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

