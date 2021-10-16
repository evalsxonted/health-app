import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy/models/user-info.dart';
import 'package:toast/toast.dart';

class Complaints extends StatefulWidget {
  final UserInfo userInfo;
  const Complaints({Key key, this.userInfo}) : super(key: key);
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  TextEditingController complaintsText;
  FirebaseFirestore firestore;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    complaintsText = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 20, top: 20),
                      child: Image.asset(
                        "assets/icons/back.png",
                        width: 30,
                        height: 30,
                      )),
                ),
              ),
              Container(

                height: 200, width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png"), )
                  // Image.asset("assets/logo.png", height: 200, width: 200,)
                ),
                child: Center(
                  child: Text(
                    "Sehaty",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "robotic"
                    ),
                  ),
                ),
              ),
              Text("اقتراحات وشكاوى", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(controller: complaintsText, maxLines: 5,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "اكتب المقترحات والشكاوى هنا",
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                ),),
              ),
              InkWell(
                onTap: () {
                  if(widget.userInfo.id == "guest"){
                    return ;
                  }

                  if(complaintsText.text != ""){
                    firestore.collection("complaints").add({
                      "comp" : complaintsText.text,
                      "userName" : widget.userInfo.name,
                      "date" : DateTime.now(),
                    }).then((value) {
                      Toast.show("successfully added", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, bottom: 40),
                  height: 60,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/button.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "ارسل",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
