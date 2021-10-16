
import 'dart:developer';
import 'package:healthy/presentation/widgets/input.dart';

import 'home/home.dart';
import 'package:healthy/models/user-info.dart';
import 'package:toast/toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseFirestore firestore;

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController passController;
  TextEditingController passConfirmController;
  DateTime birthDate;
  bool male;
  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    passController = new TextEditingController();
    passConfirmController = new TextEditingController();
    male = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: 320,
                      height: 220,
                      margin: EdgeInsets.all(50),
                      child: Image.asset("assets/login.png")),
                  Positioned(
                    right: -1,
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
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/person2.png",
                    controller: nameController,
                    hintText: "الاسم الكامل",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/email.png",
                    controller: emailController,
                    hintText: "البريد الالكتروني",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/phone.png",
                    controller: phoneController,
                    hintText: "رقم الهاتف",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/pass2.png",
                    controller: passController,
                    hintText: "كلمة السر",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/pass2.png",
                    controller: passConfirmController,
                    hintText: "تاكيد كلمة السر",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, offset: Offset(0, 1))
                        ]),
                    margin: EdgeInsets.all(10),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onTap: pickBirthDate,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                            width: 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/icons/birth.png"),fit: BoxFit.fill),
                            ),
                          ),
                          hintText: birthDate == null? "تاريخ الميلاد" : "تم اختيار التاريخ",
                          hintStyle: TextStyle(fontSize: 14), // you need this
                        ),
                      ),
                    ),
                  )
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          male = false;
                        });
                      },
                      child: Container(
                        width:18,
                        height: 18,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/icons/open_circle.png"))
                        ),
                        child:  !male? Image.asset("assets/icons/closed_circle.png") : Container(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("انثى"),
                    ),
                    SizedBox(width: 15,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          male = true;
                        });
                      },
                      child: Container(
                        width:18,
                        height: 18,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/icons/open_circle.png"))
                        ),
                        child:  male? Image.asset("assets/icons/closed_circle.png") : Container(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("ذكر"),
                    ),
                    SizedBox(width: 20,),

                    Container(
                      width:25,
                      height: 25,
                      child:  Image.asset("assets/icons/sex.png"),
                    ),
                    Text("الجنس"),



                  ],
                ),
              ),
              InkWell(
                onTap: signUp,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, bottom: 40),
                  height: 70,
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/button.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "انشاء",
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

  pickBirthDate(){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1920, 1, 1),
        maxTime: DateTime(2022, 1, 1), onChanged: (date) {
          log(date.toString());
        }, onConfirm: (date) {
        setState(() {
          birthDate = date;
        });
        }, currentTime: DateTime.now(), locale: LocaleType.ar);
  }
  signUp() async {
      if(
      nameController.text == "" ||
          birthDate == null ||
          passController.text == "" ||
          emailController.text == "" ||
          phoneController.text == "" ||
          passConfirmController.text == ""
      ){
        Toast.show("empty fields", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }else{
        int phoneNumber ;
        try {
          phoneNumber = int.parse(phoneController.text);
        } catch (e) {
          Toast.show("not valid phone", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          return;
        }

        firestore.collection("users").where("email",isEqualTo: emailController.text).get().then((value) {
          if(value.size > 0){
            Toast.show("user already exist", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }else{
            UserInfo userInfo = UserInfo(
              female: !male,
              password: passController.text,
              email: emailController.text,
              birthDate: birthDate,
              name: nameController.text,
              phone: phoneNumber,
            );
            firestore.collection("users").add(userInfo.userToMap()).then((value) {
              userInfo.id = value.id;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(userInfo: userInfo,),));
            });
          }
        });
      }
  }
}
