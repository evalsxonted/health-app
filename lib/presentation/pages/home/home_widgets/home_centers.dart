import 'package:flutter/material.dart';
import 'package:healthy/models/center_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/home/home_cards/center_card.dart';

class HomeCenters extends StatelessWidget {
  final List<CenterInfo> centers;
  final UserInfo userInfo;
  const HomeCenters({Key key, this.centers, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      key: Key("center"),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: centers.length,
      itemBuilder: (context, index) {
        return CenterCard(
          centerInfo: centers[index],
          userInfo: userInfo,
        );
      },
    );
  }
}
