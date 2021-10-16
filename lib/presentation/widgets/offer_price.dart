import 'package:flutter/material.dart';

class OfferPrice extends StatelessWidget {
  final int discountPercent;
  final int oldPrice;
  final int newPrice;

  const OfferPrice({Key key, this.discountPercent, this.oldPrice, this.newPrice}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 1,
      bottom: 1,
      child: Padding(
        padding:  EdgeInsets.only(left: 20, bottom: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffDC3C4D)
              ),
              margin: EdgeInsets.only(bottom: 5),
              child: Padding(
                padding:  EdgeInsets.only(right: 8, left: 8, top: 5, bottom: 5),
                child: Text( "خصم"  + "   %" +  discountPercent.toString()  , style: TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    color: Colors.white
                ),),
              ),
            ),
            Text(
              oldPrice.toString() + " دينار ",
              style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 1, offset: Offset.fromDirection(0.1)),
                  ]
              ),
            ),
            Text(
              newPrice.toString() + " دينار ",
              style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 1, offset: Offset.fromDirection(0.1)),
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
