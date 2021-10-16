import 'package:flutter/material.dart';

class AwesomeDropdown extends StatefulWidget {
  final List<String> textList;
  final String selected;
  final Function onChangeFunction;
  const AwesomeDropdown({Key key, this.textList, this.selected, this.onChangeFunction}) : super(key: key);

  @override
  _AwesomeDropdownState createState() => _AwesomeDropdownState();
}

class _AwesomeDropdownState extends State<AwesomeDropdown> {
  String selected;
  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Color(0xfff5f5f5),
      itemBuilder: (context) {
        return widget.textList.map((str) {
          return PopupMenuItem(
            value: str,
            child: Text(str),
          );
        }).toList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(selected, style: TextStyle(fontSize: 22, color: Color(0xff1A535C), fontWeight: FontWeight.w700),),
          SizedBox(width: 10,),
          Icon(Icons.keyboard_arrow_down , color: Color(0xff1A535C), size: 40,),
        ],
      ),
      onSelected: (v) {
        widget.onChangeFunction(v);
        setState(() {
          selected = v;
        });
      },
    );
  }
}