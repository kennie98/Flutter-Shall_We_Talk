import 'package:shall_we_talk/models/user.dart';
import 'package:shall_we_talk/models/user_info.dart';
import 'package:shall_we_talk/screens/home/user_info_list.dart';
import 'package:shall_we_talk/screens/home/user_map.dart';
import 'package:shall_we_talk/services/auth.dart';
import 'package:shall_we_talk/services/database.dart';
import 'package:shall_we_talk/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:shall_we_talk/shared/global_style.dart' as global_style;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserInfo>(
        stream: DatabaseService(uid: user.uid).userInfoOfUid,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserInfo userInfo = snapshot.data;

            return StreamProvider<List<UserInfo>>.value(
              value: DatabaseService().userInfo,
              child: MaterialApp(
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
                              userInfo.gender == 'Male'
                                  ? 'images/male_avata.png'
                                  : 'images/female_avata.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${userInfo.name}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${userInfo.pro ? 'Professional' : 'Normal User'}',
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
                        icon: Icon(Icons.location_on),
                        label: Text('Location'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new UserInfoPage(),
                            ),
                          );
                        },
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text('Logout'),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                    ],
                    bottom: new TabBar(
                      tabs: <Tab>[
                        new Tab(
                          text: "Normal Users",
                          icon: new Icon(Icons.account_circle),
                        ),
                        new Tab(
                          text: "Professionals",
                          icon: new Icon(Icons.account_circle),
                        ),
                      ],
                      controller: _tabController,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/forest.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: UserInfoListPro(false, true, user.uid),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/forest.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: UserInfoListPro(true, true, user.uid),
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
