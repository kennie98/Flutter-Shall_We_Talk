import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shall_we_talk/shared/global_style.dart' as global_style;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(global_style.color6),
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.amber,
          size: 80.0,
        ),
      ),
    );
  }
}