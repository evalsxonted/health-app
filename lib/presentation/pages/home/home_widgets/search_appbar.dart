import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function searchFunction;
  final Function openSearchFunction;
  const SearchAppBar({Key key, this.searchFunction, this.openSearchFunction}) : super(key: key);@override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffE5E5E5),
      elevation: 5,
      title: TextField(
        onSubmitted: (v) {
          searchFunction(v);
        },
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: "البحث",
          hintStyle: TextStyle(fontSize: 18),
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Image.asset(
                "assets/icons/close.png",
                width: 20,
                height: 20,
              ),
              onPressed: openSearchFunction),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }


}
