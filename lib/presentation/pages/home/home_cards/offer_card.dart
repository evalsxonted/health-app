import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/profiles/offer_profile.dart';
import 'package:healthy/presentation/widgets/offer_overlayed_image.dart';
import 'package:healthy/presentation/widgets/offer_price.dart';
import 'package:healthy/presentation/widgets/offer_provider.dart';
import 'package:healthy/presentation/widgets/card_rating_bar.dart';

class OfferCard extends StatelessWidget {

  final OfferInfo offerInfo;
  final bool clickable;
  final UserInfo userInfo;
  const OfferCard({Key key, this.offerInfo, this.clickable, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: (){
          if(clickable)
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OfferProfile(offerInfo:  offerInfo, userInfo: userInfo,)));
        },
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black54,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            child: Stack(
              children: [
                OfferImage(
                  networkImage:  offerInfo.image,
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Padding(
                    padding:  EdgeInsets.only(right: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                           offerInfo.offerName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OfferProvider(
                          offerInfo: offerInfo,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            MyRatingBar(
                              initialRating: offerInfo.rating,
                            ),
                            Text(
                              "زائر " + offerInfo.visitors.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.2,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                OfferPrice(
                  discountPercent: offerInfo.discountPercent,
                  newPrice: offerInfo.newPrice,
                  oldPrice: offerInfo.oldPrice,
                ),
              ],
            )
        ),
      ),
    );
  }

}

