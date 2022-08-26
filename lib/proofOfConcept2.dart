import 'dart:async';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NetworkImageCustomMarker3 extends StatefulWidget {





  @override
  State<NetworkImageCustomMarker3> createState() => _NetworkImageCustomMarker3State();
}

class _NetworkImageCustomMarker3State extends State<NetworkImageCustomMarker3> {
  var _selectedIndex = 0;
  int activeIndex = 0;

  final controller = CarouselController();


  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.3304, -121.7922),
    zoom: 9,
  );

  List<String> urls = ['https://drive.google.com/uc?export=view&id=1rhB4ZdzqdgKAXzMpokqXmVd4j2_eTT11',
    'https://images.pexels.com/photos/3023479/pexels-photo-3023479.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/89731/pexels-photo-89731.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/298217/pexels-photo-298217.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/7645874/pexels-photo-7645874.jpeg?auto=compress&cs=tinysrgb&w=600',

  ];
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




  // Widget buildBottomSheet(BuildContext context){
  //   return
  //
  //
  // }

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

  void showAlertDialog1(){
    showDialog(
        context: context,
        builder: (context){
          return Container(
            height: 600,
            child: Theme(

              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    carouselController: controller,
                      itemCount: urls.length,
                      options: CarouselOptions(
                          height: 400,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason){
                            setState((){
                              activeIndex = index;
                            });
                        }
                      ),
                      itemBuilder: (context,index,newIndex){
                        final urlImage = urls[index];
                        return buildImage( urlImage, index );
                      },
                  ),
                  SizedBox(height: 60,),
                  //buildIndicator()
                  CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: urls.length,
                    options: CarouselOptions(
                        height: 20,


                        initialPage: 2,
                        viewportFraction: 0.1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason){
                          setState((){
                            activeIndex = index;
                          });
                        }
                    ),
                    itemBuilder: (context,index,newIndex){
                      final urlImage = urls[index];
                      return buildImage( urlImage, index );
                    },
                  ),

                ],
              ),
            ),


          );
        });
  }

  Widget buildImage(String urlImage ,int index ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Image.network(urlImage,fit: BoxFit.cover,),
    );
  }

  // Widget buildIndicator(){
  //   return AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: urls.length,
  //   );
  //
  // }
  void animateToSlide(int index) => controller.animateToPage(index);

  // void showAlertDailog1(){
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //         return Container(
  //           padding: EdgeInsets.symmetric(vertical: 100),
  //           child: Column(
  //             children: [
  //               Theme(
  //                 data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
  //                 child: Container(
  //                   height: 300,
  //                   child: PageView.builder(
  //                       onPageChanged: (index){
  //                         setState((){
  //                           _selectedIndex = index;
  //                         });
  //                       },
  //                       controller: PageController(viewportFraction: 0.7),
  //                       itemCount: urls.length,
  //                       itemBuilder: (context, index){
  //                         return Container(
  //                           margin: EdgeInsets.symmetric(horizontal: 10),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(12),
  //                             image: DecorationImage(
  //                               image: NetworkImage(urls[index]),
  //                               fit: BoxFit.cover,
  //                             ),
  //
  //                           ),
  //
  //
  //                         );
  //                       }),
  //                 ),
  //               ),
  //               SizedBox(height: 15,),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ...List.generate(urls.length,
  //                           (index) =>
  //                           Indicator(
  //                             isActive: _selectedIndex == index ? true: false,
  //
  //                           ) ),
  //
  //
  //                 ],
  //               ),
  //             ],
  //
  //
  //           ),
  //         );
  //       }
  //   );
  // }

  loadData() async{
    for (int i = 0; i < _latLang.length; i++) {

      Uint8List? image = await loadNetworkImage(urls[i]);

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
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
                showAlertDialog1();
                //showModalBottomSheet(context: context, builder: buildBottomSheet,backgroundColor: Colors.transparent);

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
