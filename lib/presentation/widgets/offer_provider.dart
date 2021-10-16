import 'package:flutter/material.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/utilities/singletons.dart';

class OfferProvider extends StatelessWidget {
  final OfferInfo offerInfo;
  const OfferProvider({Key key, this.offerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProvider(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Text(
            "مزود الخدمة",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1),
          );
        }else{
          return Text(
            snapshot.data,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1),
          );
        }
      },);
  }
  getProvider() async {
    String offerProvider = offerInfo.providerCenter !=null ? offerInfo.providerCenter :
    offerInfo.providerPharma !=null ?  offerInfo.providerPharma : offerInfo.providerDoctor;
    String fireCollection =  offerInfo.providerCenter !=null ? "centers" :
    offerInfo.providerPharma !=null ?  "pharmas" :  "doctors";
    var result = await FirestoreInstance.call.collection(fireCollection).doc(offerProvider).get();
    return result.data()["name"];
  }
}
