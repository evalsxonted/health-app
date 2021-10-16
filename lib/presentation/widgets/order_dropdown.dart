import 'package:flutter/material.dart';

class OrderDropdown extends StatefulWidget {
  final List<String> textList;
  final String selected;
  final Function onChangeFunction;
  const OrderDropdown({Key key, this.textList, this.selected, this.onChangeFunction}) : super(key: key);

  @override
  _OrderDropdownState createState() => _OrderDropdownState();
}

class _OrderDropdownState extends State<OrderDropdown> {
  String selected;
  // List<String> items;
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
          if(str == "الترتيب حسب"){
            return PopupMenuItem(
              value: str,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      str,
                      style: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ),
            );
          }
          return PopupMenuItem(
            value: str,
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(str),

                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width:18,
                    height: 18,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/icons/open_circle.png"))
                    ),
                    child:  selected == str? Image.asset("assets/icons/closed_circle.png") : Container(),
                  ),
                ],
              ),
            ),
          );
        }).toList();
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Image.asset(
              "assets/icons/filter.png",
              width: 20,
              height: 20,
            ),
      ),
      onSelected: (v) {
        if(v == "الترتيب حسب"){
          return;
        }
        widget.onChangeFunction(v);
        setState(() {
          selected = v;
        });
      },
    );
  }
}