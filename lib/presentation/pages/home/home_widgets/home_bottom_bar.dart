import 'package:flutter/material.dart';
import 'package:healthy/presentation/pages/home/home_constants.dart';

class HomeBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function onSelect;
  const HomeBottomBar({Key key, this.selectedIndex, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            selectedIndex == 0
                ? "assets/icons/offers.png"
                : "assets/icons/offers2.png",
            height: 35,
            width: 35,
          ),
          label: HomeConstants().branches[0],
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            selectedIndex == 1
                ? "assets/icons/center.png"
                : "assets/icons/center2.png",
            height: 35,
            width: 35,
          ),
          label: HomeConstants().branches[1],
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            selectedIndex == 2
                ? "assets/icons/pharmacy.png"
                : "assets/icons/pharmacy2.png",
            height: 35,
            width: 35,
          ),
          label: HomeConstants().branches[2],
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            selectedIndex == 3
                ? "assets/icons/doctor.png"
                : "assets/icons/doctor2.png",
            height: 35,
            width: 35,
          ),
          label: HomeConstants().branches[3],
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onSelect,
    );
  }
}
