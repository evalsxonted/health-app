import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy/utilities/firestore_handler.dart';

import 'presentation/pages/login.dart';
import 'package:healthy/models/user-info.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'presentation/pages/home/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffE5E5E5)
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Cairo",
        primaryColor: Color(0xff1A535C),
        canvasColor: Color(0xff1A535C),
      ),
      home: FutureBuilder(
          future: initializeApp(),
          builder: (ctx, snp){
        if(!snp.hasData){
          return Scaffold(
            backgroundColor: Color(0xffE5E5E5),
            body: Center(child: Text("loading...."),),
          );
        }else{
          return snp.data == "" ? Login(): FutureBuilder(
          future: FirestoreHandler().getUser(snp.data),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Scaffold(
                    backgroundColor: Color(0xffE5E5E5),
                    body: Center(child: Text("loading....")));
              }else{
                return Home(
                  userInfo: mapToUserInfo(snapshot.data),
                );
              }
            },
          );
        }
      }),
    );
  }

  Future initializeApp() async {
    await Firebase.initializeApp();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    Box prefsBox = await Hive.openBox("prefs");
    String userInfo = await prefsBox.get("userId") ?? "";
    return userInfo;
  }
}
