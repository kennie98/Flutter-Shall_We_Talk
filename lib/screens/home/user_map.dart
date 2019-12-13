import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation Google Maps Demo',
      home: MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
/*          Container(
            height: 60,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
            ),
          ),*/
      body: GoogleMap(
        mapType: MapType.normal, //hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(43.4526732, -79.6840743),
          zoom: 15,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'Get Location',
        child: Icon(Icons.flag),
      ),
    );
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      print('latitude:${currentLocation.latitude}, longtitude:${currentLocation.longitude}');
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }
}
