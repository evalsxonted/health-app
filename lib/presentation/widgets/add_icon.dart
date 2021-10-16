import 'package:flutter/material.dart';

class AddIcon extends StatelessWidget {
  final Function function;

  const AddIcon({Key key, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.add_box),
        onPressed:function);
  }
}
