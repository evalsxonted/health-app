import 'dart:ui';

import 'package:flutter/material.dart';

class OfferImage extends StatelessWidget {
  final String networkImage;
  const OfferImage({Key key, this.networkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.8 * 0.7,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(networkImage,),fit: BoxFit.fill),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.0,
                sigmaY: 1.0,
              ),
              child: Container(
                color: Colors.black45,
              )
          ),
        ),
      ],
    );
  }
}
