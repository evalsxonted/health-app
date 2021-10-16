import 'package:flutter/material.dart';
import 'package:healthy/models/center_info.dart';
import 'package:healthy/models/comment_info.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/dialogs/add_comment.dart';
import 'package:healthy/presentation/widgets/card_rating_bar.dart';
import 'package:healthy/presentation/widgets/location_button.dart';
import 'package:healthy/presentation/widgets/profile_icon_text.dart';
import 'package:healthy/presentation/widgets/profile_image.dart';
import 'doctor_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CenterProfile extends StatefulWidget {
  final CenterInfo centerInfo;
  final UserInfo userInfo;
  const CenterProfile({Key key, this.centerInfo, this.userInfo}) : super(key: key);
  @override
  _CenterProfileState createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
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
                                    MyRatingBar(
                                      initialRating: widget.centerInfo.rating,
                                    ),
                                    Text(
                                      "زائر " + widget.centerInfo.visitors.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MapButton(
                                map: widget.centerInfo.map,
                              ),
                            ],
                          ),
                          Text(widget.centerInfo.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),),
                          Text(widget.centerInfo.profession, style: TextStyle(fontSize: 18, height: 1.2),),
                          SizedBox(height: 14,),
                          Text(widget.centerInfo.description, style: TextStyle(fontSize: 16, height: 1.2),),
                          SizedBox(height: 10,),
                          ProfileIconText(
                            text: widget.centerInfo.location,
                            assetIconImage: "assets/icons/location2.png",
                          ),
                          SizedBox(height: 6,),
                          ProfileIconText(
                            text: widget.centerInfo.phone.toString(),
                            assetIconImage: "assets/icons/phone2.png",
                          ),
                          SizedBox(height: 6,),
                          ProfileIconText(
                            text: widget.centerInfo.workTime,
                            assetIconImage: "assets/icons/time.png",
                          ),
                        ],
                      ),
                    ),
                    ProfileImage(
                      networkImage: widget.centerInfo.image,
                    ),
                    BackButton(),
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
                          Text("معلومات وخدمات المركز", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(widget.centerInfo.about, style: TextStyle(fontSize: 16, height: 1.2),),

                    ],
                  ),
                ),
                widget.centerInfo.doctorsId.length == 0? Container():
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
                          Text("اطباء المراكز", style: TextStyle(fontSize: 18, height: 1.2, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      FutureBuilder(
                        future: getDoctors(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("جاري التحميل...");
                          } else {
                            List<DoctorInfo> pharmaDoctors = snapshot.data;
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pharmaDoctors.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorProfile(
                                        doctorInfo: pharmaDoctors[index], userInfo: widget.userInfo,)));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          margin:
                                          EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                  Color(0xff1A535C),
                                                  width: 2),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  pharmaDoctors[index]
                                                      .image,
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pharmaDoctors[index].name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.2,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              pharmaDoctors[index]
                                                  .profession,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.2),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
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
                          .where("providerId", isEqualTo: widget.centerInfo.id).snapshots(),
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
          providerId: widget.centerInfo.id,
          userName: widget.userInfo.name,
        );
      },
    );
  }
  getDoctors() async {
    List<DoctorInfo> tempDoctors = [];
    for(int i = 0 ; i < widget.centerInfo.doctorsId.length ; i++){
      var result = await FirebaseFirestore.instance.collection("doctors").doc(widget.centerInfo.doctorsId[i]).get();
      var tempData = result.data();
      tempData['id'] = result.id;
      tempDoctors.add(mapToDoctor(tempData));
    }
    return tempDoctors;
  }
}
