import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CallNo {
  List<Map<String, dynamic>> callNoInfo = [];

  void clearSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('callNoInfo', ['']);
  }

  void loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> _call_no_info =
        sharedPreferences.getStringList('callNoInfo') ?? [];
    callNoInfo = _stringListToMapList(_call_no_info);
  }

  void saveData() async {
    List<String> _call_no_info = _mapListToStringList(callNoInfo);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('callNoInfo', _call_no_info);
  }

  void incrementCallNo(String phoneNo) {
    bool found = false;
    callNoInfo.forEach((item) {
      if (item.containsValue(phoneNo)) {
        item['Count']++;
        found = true;
      }
    });
    if (!found) {
      callNoInfo.add({'PhoneNo': phoneNo, 'Count': 1});
    }
    saveData();
  }

  int getCallNo(String phoneNo) {
    for(var item in callNoInfo) {
      if (item.containsValue(phoneNo)) {
        return item['Count'];
      }
    }
    return 0;
  }

  List<Map<String, dynamic>> _stringListToMapList(List<String> ls) {
    List<Map<String, dynamic>> lm = [];
    if (ls.length != 0) {
      ls.forEach((item) {
        if (item != '') {
          lm.add(json.decode(item));
        }
      });
    }
    return lm;
  }

  List<String> _mapListToStringList(List<Map<String, dynamic>> lm) {
    List<String> ls = [];
    lm.forEach((item) {
      ls.add(json.encode(item));
    });
    return ls;
  }
}
