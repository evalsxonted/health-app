
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy/models/center_info.dart';
import 'package:healthy/models/comment_info.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/models/pharma_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/dialogs/add_comment.dart';
import 'package:healthy/presentation/pages/home/home_cards/offer_card.dart';
import 'package:healthy/presentation/pages/profiles/pharma_profile.dart';
import 'center_profile.dart';
import 'doctor_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferProfile extends StatefulWidget {
  final OfferInfo offerInfo;
  final UserInfo userInfo;
  const OfferProfile({Key key, this.offerInfo, this.userInfo}) : super(key: key);
  @override
  _OfferProfileState createState() => _OfferProfileState();
}

class _OfferProfileState extends State<OfferProfile> {
  List<String> weekDays;
  bool moreComments;
  @override
  void initState() {
    moreComments = false;
    weekDays = [
      "الاثنين",
      "الثلاثاء",
      "الاربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
      "الاحد",
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A535C),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 60, left: 5, right: 5),
                        child: OfferCard(offerInfo:  widget.offerInfo, clickable: false,)),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        width: 250,
                        height: 50,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(widget.offerInfo.offerName, style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold, color: Colors.white),)),
                      ),
                    ),
                    Positioned(
                      right: -1,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 20, top: 20),
                            child: Image.asset(
                              "assets/icons/back2.png",
                              width: 30,
                              height: 30,
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                  margin: EdgeInsets.only(right: 20, left: 20,top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/info.png", height: 20,width: 20,),
                          SizedBox(width: 6,),
                          Text("تفاصيل العرض", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(widget.offerInfo.description, style: TextStyle(fontSize: 16, height: 1.2),),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                  margin: EdgeInsets.only(right: 20, left: 20,top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/doctor3.png", height: 20,width: 20,),
                          SizedBox(width: 6,),
                          Text("مزود الخدمة", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      widget.offerInfo.providerCenter != null ? FutureBuilder(
                        future:  FirebaseFirestore.instance.collection("centers").doc(widget.offerInfo.providerCenter).get(),
                        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Container();
                          }else{
                            var tempData = snapshot.data.data();
                            tempData["id"] = snapshot.data.id;
                            CenterInfo centerInfo = mapToCenter(tempData);
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CenterProfile(centerInfo: centerInfo, userInfo: widget.userInfo,)));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff1A535C), width: 2),
                                          borderRadius: BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              centerInfo.image,
                                            ),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(centerInfo.name, style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                                        Text(centerInfo.profession, style: TextStyle(fontSize: 16, height: 1.2),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ) : Container(),
                      widget.offerInfo.providerDoctor != null ? FutureBuilder(
                        future:  FirebaseFirestore.instance.collection("doctors").doc(widget.offerInfo.providerDoctor).get(),
                        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Container();
                          }else{
                            var tempData = snapshot.data.data();
                            tempData["id"] = snapshot.data.id;
                            DoctorInfo centerInfo = mapToDoctor(tempData);
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorProfile(doctorInfo: centerInfo,userInfo: widget.userInfo,)));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff1A535C), width: 2),
                                          borderRadius: BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              centerInfo.image,
                                            ),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(centerInfo.name, style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                                        Text(centerInfo.profession, style: TextStyle(fontSize: 16, height: 1.2),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ) : Container(),
                      widget.offerInfo.providerPharma != null ? FutureBuilder(
                        future:  FirebaseFirestore.instance.collection("pharmas").doc(widget.offerInfo.providerPharma).get(),
                        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Container();
                          }else{
                            var tempData = snapshot.data.data();
                            tempData["id"] = snapshot.data.id;
                            PharmaInfo centerInfo = mapToPharma(tempData);
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PharmaProfile(pharmaInfo: centerInfo, userInfo: widget.userInfo,)));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff1A535C), width: 2),
                                          borderRadius: BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              centerInfo.image,
                                            ),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(centerInfo.name, style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                                        Text(centerInfo.location, style: TextStyle(fontSize: 16, height: 1.2),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ) : Container(),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                  margin: EdgeInsets.only(right: 20, left: 20,top: 15, bottom: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/star.png", height: 20,width: 20,),
                          SizedBox(width: 6,),
                          Text("التقييمات والمراجعات", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("comments")
                            .where("providerId", isEqualTo: widget.offerInfo.id).snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Text("جاري التحميل...", style: TextStyle(fontSize: 16, height: 1.2),);
                          }else {
                            List<Comment> comments = [];
                            snapshot.data.docs.forEach((element) {
                              comments.add(mapToComment(element.data()));
                            });
                            if(comments.length == 0){
                              return Text("لا يوجد تقييمات بعد", style: TextStyle(fontSize: 16, height: 1.2),);
                            }else{
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: moreComments ? comments.length : comments.length>=2? 2 : comments.length,
                                itemBuilder: (context, index) {
                                  String dateString =  weekDays[comments[index].date.weekday -1]
                                      + " " +
                                      comments[index].date.toIso8601String().substring(0, comments[index].date.toIso8601String().indexOf("T"));
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: comments[index].rating,
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
                                      ),
                                      SizedBox(height: 6,),
                                      Text(comments[index].comment, style: TextStyle(fontSize: 16, height: 1.2), maxLines: 10, overflow: TextOverflow.ellipsis,),
                                      SizedBox(height: 8,),
                                      Text(comments[index].userName, style: TextStyle(fontSize: 16, height: 1.2, color: Color(0xff909090)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      Text(
                                        dateString,
                                        style: TextStyle(fontSize: 16, height: 1.2, color: Color(0xff909090)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 0.5,
                                        color: Color(0xff909090),
                                        margin: EdgeInsets.only( left:  15,  bottom: 20, top: 5),
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                moreComments = !moreComments;
                              });
                            },
                            child: Text(moreComments ? "عرض اقل":"المزيد", style: TextStyle(fontSize: 16, color: Color(0xff2A9D8F),
                                decoration: TextDecoration.underline ,fontWeight: FontWeight.bold), ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: InkWell(
                              onTap: (){
                                showAddCommentDialog(context);
                              },
                              child: Text("اضافة تعليق", style: TextStyle(fontSize: 16, color: Color(0xff2A9D8F),
                                  decoration: TextDecoration.underline , fontWeight: FontWeight.bold), ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showAddCommentDialog(BuildContext ctx) async {
    return showDialog<bool>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AddComment(
          userName: widget.userInfo.name,
          providerId: widget.offerInfo.id,
        );
      },
    );
  }

}
