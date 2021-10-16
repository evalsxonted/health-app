import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
class MapButton extends StatelessWidget {
  final String map;

  const MapButton({Key key, this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String firstCordinate = map.substring(0, map.indexOf(","));
        String secondCordinate =  map.substring(map.indexOf(",")+2);
        MapsLauncher.launchCoordinates( double.parse(firstCordinate) , double.parse(secondCordinate));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 2, bottom: 8),
        width: 100,
        child: Image.asset("assets/icons/map.png", width: 50, height: 50,),
      ),
    );
  }
}
