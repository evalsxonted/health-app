import 'package:flutter/material.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/dialogs/logout.dart';
import 'package:share/share.dart';

import '../../account.dart';
import '../../complaints.dart';

class HomeDrawer extends StatelessWidget {
  final UserInfo userInfo;
  const HomeDrawer({Key key, this.userInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        alignment: Alignment.centerRight,
        // decoration: BoxDecoration(
        //   color: Color(0xff35363A),
        // ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff2A9D8F),
              Color(0xff237C78),
              Color(0xff1A535C),
            ],
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, bottom: 20),
                child: Text(
                  userInfo.name, style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Account(userInfo: userInfo,)));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/person3.png", height: 25, width: 25,),
                      SizedBox(width: 20,),
                      Text(
                        "الحساب", style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   padding: EdgeInsets.only(right: 10, bottom: 10),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Image.asset("assets/icons/settings.png", height: 25, width: 25,),
              //       SizedBox(width: 20,),
              //       Text(
              //         "اللغة", style: TextStyle(
              //         fontSize: 24,
              //         color: Colors.white,
              //       ),),
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Complaints(userInfo: userInfo,)));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/write.png", height: 25, width: 25,),
                      SizedBox(width: 20,),
                      Text(
                        "اقتراحات وشكاوى", style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: InkWell(
                  onTap: (){
                    Share.share('انصح بتجربة تطبيق صحتي الجديد', subject: 'تطبيق صحتي', );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/share.png", height: 25, width: 25,),
                      SizedBox(width: 20,),
                      Text(
                        "مشاركة التطبيق", style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: InkWell(
                  onTap: (){
                    showLogOutDialog(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/exit.png", height: 25, width: 25,),
                      SizedBox(width: 20,),
                      Text(
                        "تسجيل خروج", style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showLogOutDialog(BuildContext ctx) async {
    return showDialog<bool>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Logout();
      },
    );
  }
}

//
