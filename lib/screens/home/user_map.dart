import 'package:flutter/material.dart';
import 'package:shall_we_talk/models/user_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shall_we_talk/shared/global_style.dart' as global_style;

class UserInfoPage extends StatefulWidget {
  final UserInfo userInfo;
  UserInfoPage({Key key, @required this.userInfo}) : super(key: key);

  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shall We Talk - Home',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: "Calibri",
        canvasColor: Colors.amberAccent,
      ),
      home: Scaffold(
        backgroundColor: Color(global_style.color6),
        appBar: new AppBar(
          title: Row(
            children: <Widget>[
              Material(
                elevation: 6.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.amberAccent,
                  backgroundImage: AssetImage(
                    widget.userInfo.gender == 'Male'
                        ? 'images/male_avata.png'
                        : 'images/female_avata.png',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.userInfo.name}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.userInfo.pro ? 'Professional' : 'Normal User'}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Back'),
              onPressed: () async {
                //await _auth.signOut();
              },
            ),
          ],
        ),
        body: MyMap(),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal, //hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(43.4526732, -79.6840743),
          zoom: 15,
        ),
        markers: _markers.values.toSet(),
      );
     /*
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'Get Location',
        child: Icon(Icons.flag),
      ),
    );*/
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
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
