import 'dart:async';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class NetworkImageCustomMarker1 extends StatefulWidget {




  @override
  State<NetworkImageCustomMarker1> createState() => _NetworkImageCustomMarker1State();
}

class _NetworkImageCustomMarker1State extends State<NetworkImageCustomMarker1> {


  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.3304, -121.7922),
    zoom: 9,
  );


  Widget buildBottomSheet(BuildContext context){
    return Container(
      height: 650,
      child: Theme(

        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
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
                aspectRatio: 16 / 8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.6,
              ),
            ),
          ],
        ),
      ),


    );


  }

  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers =  <Marker>[];

  List<LatLng> _latLang =  [
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

  void showAlertDailog(){
    showDialog(
        context: context,
        builder: (context){
          return BackdropFilter(

              filter: ImageFilter.blur(),
              child: AlertDialog(
                content: Container(

                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://drive.google.com/uc?export=view&id=1rhB4ZdzqdgKAXzMpokqXmVd4j2_eTT11'),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),

              ));
        }
    );
  }

  loadData() async{
    for (int i = 0; i < _latLang.length; i++) {

      Uint8List? image = await loadNetworkImage('https://drive.google.com/uc?export=view&id=1rhB4ZdzqdgKAXzMpokqXmVd4j2_eTT11');

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
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
              position: _latLang[i],
              icon: BitmapDescriptor.fromBytes(resizedImageMarker),
              infoWindow: InfoWindow(),
              onTap: (){
                //showAlertDailog();
                showModalBottomSheet(context: context, builder: buildBottomSheet,backgroundColor: Colors.transparent);

              }

          )

      );
      setState(() {});
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),

      ),
    );
  }
}
