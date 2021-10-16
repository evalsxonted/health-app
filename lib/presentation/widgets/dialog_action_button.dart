
import 'package:flutter/material.dart';

class DialogAction extends StatelessWidget {
  final Function function;
  final String text;
  const DialogAction({Key key, this.function, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xff2A9D8F),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
