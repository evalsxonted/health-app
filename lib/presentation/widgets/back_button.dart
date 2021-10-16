import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -1,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Image.asset(
              "assets/icons/back2.png",
              width: 30,
              height: 30,
            )),
      ),
    );
  }
}
