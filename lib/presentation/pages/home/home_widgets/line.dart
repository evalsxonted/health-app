import 'package:flutter/material.dart';

class HLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Image.asset(
        "assets/line.png",
        width: 100,
        fit: BoxFit.fitHeight,
        height: 2,
      ),
    );
  }
}
