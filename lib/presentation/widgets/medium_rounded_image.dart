import 'package:flutter/material.dart';

class MediumRoundedImage extends StatelessWidget {
  final String networkImage;

  const MediumRoundedImage({Key key, this.networkImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image.network(
          networkImage,
          height: 80.0,
          width: 80.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
