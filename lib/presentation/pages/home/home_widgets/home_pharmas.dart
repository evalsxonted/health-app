import 'package:flutter/material.dart';
import 'package:healthy/models/pharma_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/home/home_cards/pharma_card.dart';

class HomePharmas extends StatelessWidget {
  final List<PharmaInfo> pharmas;
  final UserInfo userInfo;
  const HomePharmas({Key key, this.pharmas, this.userInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      key: Key("pharmas"),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: pharmas.length,
      itemBuilder: (context, index) {
        return PharmaCard(
          pharmaInfo: pharmas[index],
          userInfo: userInfo,
        );
      },
    );
  }
}
