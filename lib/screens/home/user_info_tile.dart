import 'package:shall_we_talk/models/user_info.dart';
import 'package:flutter/material.dart';
import 'Package:shall_we_talk/screens/home/user_map.dart';
import 'Package:shall_we_talk/services/call_sms_email.dart';
import 'package:shall_we_talk/helper/call_no.dart';

class UserInfoTile extends StatefulWidget {
  final UserInfo userInfo;
  final GlobalKey<UserInfoPageState> _key = GlobalKey();
  final CallNo callNo;

  UserInfoTile({this.userInfo, this.callNo});

  @override
  _UserInfoTileState createState() => _UserInfoTileState();
}

class _UserInfoTileState extends State<UserInfoTile> {
  @override
  Widget build(BuildContext context) {
    int _callCount = widget.callNo.getCallNo(widget.userInfo.phoneno);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[widget.userInfo.age],
            backgroundImage: AssetImage(
              widget.userInfo.gender == 'Female'
                  ? 'images/female_avata.png'
                  : 'images/male_avata.png',
            ),
          ),
          title: Text(widget.userInfo.name),
          subtitle: Text((widget.userInfo.pro
              ? (((_callCount > 0) ? 'call: $_callCount - ' : '') +
                  widget.userInfo.selfIntro)
              : '')),
          trailing: ((widget.userInfo.pro)
              ? IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {
                    new CallsAndMessagesService()
                        .call('${widget.userInfo.phoneno}');
                    setState(() =>
                        widget.callNo.incrementCallNo(widget.userInfo.phoneno));
                  })
              : IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          key: widget._key,
                          userInfo: widget.userInfo,
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
