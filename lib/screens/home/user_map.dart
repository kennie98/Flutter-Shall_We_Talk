import 'package:flutter/material.dart';
import 'package:shall_we_talk/models/user_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    global_style.setPortrait();

    return MaterialApp(
      title: 'Shall We Talk - UserInfo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: "Calibri",
        canvasColor: Colors.amberAccent,
      ),
      home: Scaffold(
        backgroundColor: Color(global_style.color6),
        appBar: new AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    '${widget.userInfo.name}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.userInfo.pro ? 'Professional' : 'Normal User'}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    '${widget.userInfo.gender}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${widget.userInfo.age}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: MyMap(widget.userInfo),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  final UserInfo userInfo;
  MyMap(this.userInfo);

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    _showUserLocation(widget.userInfo);

    return GoogleMap(
      mapType: MapType.normal, //hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.userInfo.latitude, widget.userInfo.longitude),
        zoom: 15,
      ),
      markers: _markers.values.toSet(),
    );
  }

  void _showUserLocation(UserInfo userInfo) {
    _markers.clear();
    final marker = Marker(
      markerId: MarkerId("curr_loc"),
      position: LatLng(userInfo.latitude, userInfo.longitude),
      infoWindow: InfoWindow(
          title: '${userInfo.name}',
          snippet: '${userInfo.gender}, Age: ${userInfo.age}'),
    );
    _markers["User Location"] = marker;
  }
}
