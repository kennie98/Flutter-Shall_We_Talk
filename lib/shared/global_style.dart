library shall_we_talk.global_style;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final String emailDomain = '@kts.com';

final int color1 = 0xfff9fabe;
final int color2 = 0xffb1d4a1;
final int color3 = 0xFF92AE85;
final int color4 = 0xFFADADAD;
final int color5 = 0xFFADAD84;
final int color6 = 0xFFF6E7A3;
final int color7 = 0xFF525252;
final int color8 = 0xFFD1FABE;
final int color9 = 0xFFD3D4A1;

final TextStyle ts = TextStyle(
  fontFamily: 'Calibri',
  fontSize: 18.0,
  color: Color(color7),
  fontWeight: FontWeight.w100,
);

void setPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Widget styledRaisedButton(String text, Function func) {
  return RaisedButton(
    color: Colors.teal, //(color3),
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(
        color: Color(color3),
      ),
    ),
    onPressed: () {
      func();
    },
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 25.0,
        color: Color(color9),
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}

void showMessageDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(color1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: msg),
                  ),
                  SizedBox(
                    width: 100.0,
                    child: styledRaisedButton(
                      'OK',
                      () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
