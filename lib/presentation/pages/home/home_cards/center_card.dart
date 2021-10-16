import 'package:flutter/material.dart';
import 'package:healthy/models/center_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/profiles/center_profile.dart';
import 'package:healthy/presentation/widgets/medium_rounded_image.dart';
import 'package:healthy/presentation/widgets/card_rating_bar.dart';

class CenterCard extends StatelessWidget {
  final CenterInfo centerInfo;
  final UserInfo userInfo;
  const CenterCard({Key key, this.centerInfo, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CenterProfile(centerInfo: centerInfo, userInfo: userInfo,)));
        },
        child: Card(
          shadowColor: Colors.black54,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MediumRoundedImage(
                    networkImage: centerInfo.image,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          centerInfo.name ,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1.2),
                        ),
                        Text(centerInfo.profession,
                            style: TextStyle(fontSize: 16, height: 1.3)),
                        Text(centerInfo.location,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.3,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 1,
                left: 1,
                child: Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 2),
                    width: 100,
                    child: Column(
                      children: [
                        MyRatingBar(
                          initialRating: centerInfo.rating,
                        ),
                        Text(
                          "زائر " + centerInfo.visitors.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

}
