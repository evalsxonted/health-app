
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy/models/comment_info.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/dialogs/add_comment.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorProfile extends StatefulWidget {
  final DoctorInfo doctorInfo;
  final UserInfo userInfo;
  const DoctorProfile({Key key, this.doctorInfo, this.userInfo}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                      margin: EdgeInsets.only(right: 20, left: 20,top: 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 2, bottom: 8),
                                width: 100,
                                child: Column(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: widget.doctorInfo.rating,
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
                                    Text(
                                      "زائر " + widget.doctorInfo.visitors.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  String firstCordinate = widget.doctorInfo.map.substring(0, widget.doctorInfo.map.indexOf(","));
                                  String secondCordinate =  widget.doctorInfo.map.substring(widget.doctorInfo.map.indexOf(",")+2);
                                  MapsLauncher.launchCoordinates( double.parse(firstCordinate) , double.parse(secondCordinate));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 2, bottom: 8),
                                  width: 100,
                                  child: Image.asset("assets/icons/map.png", width: 50, height: 50,),
                                ),
                              ),
                            ],
                          ),
                          Text(widget.doctorInfo.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),),
                          Text(widget.doctorInfo.profession, style: TextStyle(fontSize: 18, height: 1.2),),
                          SizedBox(height: 14,),
                          Text(widget.doctorInfo.description, style: TextStyle(fontSize: 16, height: 1.2),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset("assets/icons/location2.png", height: 20,width: 20,),
                              SizedBox(width: 6,),
                              Text("العنوان:", style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                              SizedBox(width: 4,),
                              Flexible(child: Text(widget.doctorInfo.location, style: TextStyle(fontSize: 16, height: 1.2),)),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              Image.asset("assets/icons/money.png", height: 20,width: 20,),
                              SizedBox(width: 6,),
                              Text("اجور الفحص:", style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                              SizedBox(width: 4,),
                              Text(widget.doctorInfo.ticketPrice.toString(), style: TextStyle(fontSize: 16, height: 1.2),),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              Image.asset("assets/icons/phone2.png", height: 20,width: 20,),
                              SizedBox(width: 6,),
                              Text("رقم الهاتف:", style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                              SizedBox(width: 4,),
                              Text(widget.doctorInfo.phone.toString(), style: TextStyle(fontSize: 16, height: 1.2),),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              Image.asset("assets/icons/time.png", height: 20,width: 20,),
                              SizedBox(width: 6,),
                              Text("اوقات الدوام:", style: TextStyle(fontSize: 16, height: 1.2, fontWeight: FontWeight.bold),),
                              SizedBox(width: 4,),
                              Flexible(child: Text(widget.doctorInfo.workTime, style: TextStyle(fontSize: 16, height: 1.2), maxLines: 2,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff1A535C), width: 2),
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.doctorInfo.image,
                            ),
                            fit: BoxFit.fill,
                          )
                        ),
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
                          Image.asset("assets/icons/info.png", height: 20,width: 20,),
                          SizedBox(width: 6,),
                          Text("معلومات وخدمات الدكتور", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(widget.doctorInfo.about, style: TextStyle(fontSize: 16, height: 1.2),),
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
                            .where("providerId", isEqualTo: widget.doctorInfo.id).snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
                          return Text("جاري التحميل...", style: TextStyle(fontSize: 16, height: 1.2),);
                      }else {
                          List<Comment> comments = [];
                          snapshot.data.docs.forEach((element) {
                            log(element.data().toString());
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
          providerId: widget.doctorInfo.id,
          userName: widget.userInfo.name,
        );
      },
    );
  }
}
