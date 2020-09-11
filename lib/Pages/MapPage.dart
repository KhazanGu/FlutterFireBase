import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapPageState();
  }
}


class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(

        title: Text("Map"),

      ),

      body: GoogleMap(

        mapType: MapType.hybrid,

        initialCameraPosition: _kGooglePlex,

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

      ),

      floatingActionButton: FloatingActionButton.extended(

        onPressed: _goToTheLake,
        label: Text('location'),
        icon: Icon(Icons.location_on),

      ),

    );

  }

}