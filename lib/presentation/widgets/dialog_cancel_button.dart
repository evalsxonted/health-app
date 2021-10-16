import 'package:flutter/material.dart';

class DialogCancel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xffDC3C4D),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          "الغاء",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
