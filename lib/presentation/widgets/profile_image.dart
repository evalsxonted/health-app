import 'package:flutter/material.dart';
class ProfileImage extends StatelessWidget {
  final String networkImage;
  const ProfileImage({Key key, this.networkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff1A535C), width: 2),
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage(
                networkImage,
              ),
              fit: BoxFit.fill,
            )
        ),
      ),
    );
  }
}
