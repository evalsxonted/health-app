import 'package:flutter/material.dart';

class ProfileIconText extends StatelessWidget {
  final String text;
  final String assetIconImage;

  const ProfileIconText({Key key, this.text, this.assetIconImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(assetIconImage, height: 20,width: 20,),
        SizedBox(width: 6,),
        Text("رقم الهاتف:", style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
        SizedBox(width: 4,),
        Text(text, style: TextStyle(fontSize: 16, height: 1.2),),
      ],
    );
  }
}
