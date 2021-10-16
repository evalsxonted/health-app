import 'package:flutter/material.dart';

class SmallRoundedImage extends StatelessWidget {
  final String networkImage;

  const SmallRoundedImage({Key key, this.networkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xff1A535C), width: 2),
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: NetworkImage(
              networkImage,
            ),
            fit: BoxFit.fill,
          )),
    );
  }
}
