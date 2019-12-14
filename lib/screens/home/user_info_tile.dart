import 'package:shall_we_talk/models/user_info.dart';
import 'package:flutter/material.dart';
import 'Package:shall_we_talk/screens/home/user_map.dart';

class UserInfoTile extends StatelessWidget {
  final UserInfo userInfo;
  final GlobalKey<UserInfoPageState> _key = GlobalKey();

  UserInfoTile({this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[userInfo.age],
            backgroundImage: AssetImage(
              userInfo.gender == 'Female'
                  ? 'images/female_avata.png'
                  : 'images/male_avata.png',
            ),
          ),
          title: Text(userInfo.name),
          subtitle: Text(userInfo.pro ? userInfo.selfIntro : ''),
          trailing: ((userInfo.pro)
              ? IconButton(icon: Icon(Icons.textsms), onPressed: () {})
              : IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          key: _key,
                          userInfo: userInfo,
                        ),
                      ),
                    );
                  },
                )),
        ),
      ),
    );
  }
}
