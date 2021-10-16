import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy/presentation/pages/home/home_constants.dart';
import 'package:healthy/presentation/widgets/dropdown.dart';
import 'package:healthy/presentation/widgets/order_dropdown.dart';

class ProvincesAndOrderAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String selectedProvince;
  final Function changeProvince;
  final Function openDrawer;
  final Function openSearch;
  final Function changeOrderBy;
  final String orderBySelected;
  const ProvincesAndOrderAppBar({Key key, this.selectedProvince, this.changeProvince, this.openDrawer, this.openSearch, this.changeOrderBy, this.orderBySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffE5E5E5),
      elevation: 5,
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.only(left: 30),
        child: AwesomeDropdown(
          selected: selectedProvince,
          textList: HomeConstants().provinces,
          onChangeFunction: changeProvince,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Image.asset(
                "assets/icons/menu.png",
                width: 20,
                height: 20,
              ),
              onPressed: openDrawer),
        )
      ],
      leading: Row(
        children: [
          IconButton(
              icon: Image.asset(
                "assets/icons/search.png",
                width: 20,
                height: 20,
              ),
              onPressed: openSearch),
          OrderDropdown(
            onChangeFunction: changeOrderBy,
            selected: orderBySelected,
            textList: [
              "الترتيب حسب",
              "تلقائي",
              "الابجدية",
              "الاقل سعرا",
              "الاعلى سعرا",
              "عدد الزائرين",
              "الاكثر تقييما",
            ],
          ),
        ],
      ),
      leadingWidth: 96,
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}
