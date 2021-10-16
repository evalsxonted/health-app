import 'package:flutter/material.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/home/home_cards/offer_card.dart';

class HomeOffers extends StatelessWidget {
  final List<OfferInfo> offers;
  final UserInfo userInfo;

  const HomeOffers({Key key, this.offers, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      key: Key("offer"),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return OfferCard(
          offerInfo: offers[index],
          clickable: true,
          userInfo: userInfo,
        );
      },
    );
  }
}
