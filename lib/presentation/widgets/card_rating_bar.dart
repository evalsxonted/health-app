import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingBar extends StatelessWidget {
  final double initialRating;
  const MyRatingBar({Key key, this.initialRating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating:  initialRating ?? 1,
      minRating: 1,
      direction: Axis.horizontal,
      ignoreGestures: true,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 16,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
