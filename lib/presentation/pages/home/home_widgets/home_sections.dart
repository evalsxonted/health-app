import 'package:flutter/material.dart';
import 'package:healthy/presentation/pages/home/home_constants.dart';

class HomeSections extends StatelessWidget {
  final int selectedIndex;
  final Function onSectionTapped;

  const HomeSections({Key key, this.selectedIndex, this.onSectionTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 0 || selectedIndex == 3) {
      return Container(
        height: 110,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: selectedIndex == 3
              ? HomeConstants().doctorSectionsNames.length
              : HomeConstants().offerSectionsNames.length,
          itemBuilder: (context, index) => InkWell(
            onTap: ()=>onSectionTapped(index),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(selectedIndex == 3
                        ? HomeConstants().doctorSectionsImages[index]
                        : HomeConstants().offerSectionsImages[index]),
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Text(
                    selectedIndex == 3
                        ? HomeConstants().doctorSectionsNames[index]
                        : HomeConstants().offerSectionsNames[index],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
