import 'package:shall_we_talk/models/user_info.dart';
import 'package:shall_we_talk/screens/home/user_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shall_we_talk/helper/call_no.dart';

class UserInfoList extends StatefulWidget {
  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInfo>>(context) ?? [];

    return ListView.builder(
      itemCount: userInfo.length,
      itemBuilder: (context, index) {
        return UserInfoTile(userInfo: userInfo[index]);
      },
    );
  }
}

class UserInfoListPro extends StatefulWidget {
  final bool isPro;
  final bool excludeUid;
  final String uid;
  final CallNo callNo;

  UserInfoListPro(this.isPro, this.excludeUid, this.uid, this.callNo);

  @override
  _UserInfoListPro createState() => _UserInfoListPro();
}

class _UserInfoListPro extends State<UserInfoListPro> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInfo>>(context) ?? [];

    List<UserInfo> proUserInfo = _getUserInfoList(
      userInfo,
      widget.isPro,
      widget.excludeUid,
      widget.uid,
    );

    return ListView.builder(
      itemCount: proUserInfo.length,
      itemBuilder: (context, index) {
        return UserInfoTile(
            userInfo: proUserInfo[index], callNo: widget.callNo);
      },
    );
  }
}

List<UserInfo> _getUserInfoList(
    List<UserInfo> p, bool isPro, bool excludeUid, String uid) {
  List<UserInfo> l = <UserInfo>[];
  p.forEach((item) {
    if (item.pro == isPro) {
      if (!excludeUid || uid != item.uid) {
        l.add(item);
      }
    }
  });
  return l;
}
