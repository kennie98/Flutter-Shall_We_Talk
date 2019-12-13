import 'package:shall_we_talk/models/user.dart';
import 'package:shall_we_talk/models/user_info.dart';
import 'package:shall_we_talk/services/database.dart';
import 'package:shall_we_talk/shared/constants.dart';
import 'package:shall_we_talk/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName;
  String _currentGender;
  int _currentAge;
  String _currentSelfIntro;
  bool _currentPro;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserInfo>(
      stream: DatabaseService(uid: user.uid).userInfoOfUid,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserInfo userInfo = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userInfo.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                  value: _currentAge ?? userInfo.age,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentAge = val ),
                ),
                SizedBox(height: 10.0),
                Slider(
                  value: (_currentAge ?? userInfo.age).toDouble(),
                  activeColor: Colors.brown[_currentAge ?? userInfo.age],
                  inactiveColor: Colors.brown[_currentAge ?? userInfo.age],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentAge = val.round()),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentGender ?? snapshot.data.gender,
                        _currentName ?? snapshot.data.name,
                        _currentAge ?? snapshot.data.age,
                        _currentSelfIntro ?? snapshot.data.selfIntro,
                        _currentPro ?? snapshot.data.pro,
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}