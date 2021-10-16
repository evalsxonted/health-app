
import 'package:flutter/material.dart';
import 'package:healthy/models/user-info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:healthy/presentation/widgets/input.dart';
import 'package:toast/toast.dart';

class Account extends StatefulWidget {
  final UserInfo userInfo;

  const Account({Key key, this.userInfo}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController passController;
  Map<String, bool> enabledInputs;
  DateTime birthDate;
  bool male;
  @override
  void initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    passController = new TextEditingController();
    male = true;
    enabledInputs = {
      "name" : true,
      "email" : true,
      "phone" : true,
      "pass" : true,
      "birth" : true,
    };
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
                    readOnly:  enabledInputs["name"],
                    prefixIcon: "assets/icons/person2.png",
                    controller: nameController,
                    hintText: "الاسم الكامل",
                    suffixIcon: "assets/edit.png",
                    suffixIconFunction: (){
                      setState(() {
                        enabledInputs["name"] = false;
                      });
                    },
                    suffixIcon2: "assets/icons/right.png",
                    suffixIconFunction2: (){
                      setState(() {
                        enabledInputs["name"] = true;
                      });
                    },
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
                    readOnly:  enabledInputs["email"],
                    suffixIcon: "assets/edit.png",
                    suffixIconFunction: (){
                      setState(() {
                        enabledInputs["email"] = false;
                      });
                    },
                    suffixIcon2: "assets/icons/right.png",
                    suffixIconFunction2: (){
                      setState(() {
                        enabledInputs["email"] = true;
                      });
                    },
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
                    readOnly:  enabledInputs["phone"],
                    suffixIcon: "assets/edit.png",
                    suffixIconFunction: (){
                      setState(() {
                        enabledInputs["phone"] = false;
                      });
                    },
                    suffixIcon2: "assets/icons/right.png",
                    suffixIconFunction2: (){
                      setState(() {
                        enabledInputs["phone"] = true;
                      });
                    },
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
                    readOnly:  enabledInputs["pass"],
                    suffixIcon: "assets/edit.png",
                    suffixIconFunction: (){
                      setState(() {
                        enabledInputs["pass"] = false;
                      });
                    },
                    suffixIcon2: "assets/icons/right.png",
                    suffixIconFunction2: (){
                      setState(() {
                        enabledInputs["pass"] = true;
                      });
                    },
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
                margin: EdgeInsets.only(top: 20, bottom: 40),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: updateAccountAction,
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff2A9D8F),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Text(
                        "حفظ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xffDC3C4D),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Text(
                        "الغاء",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
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
        }, onConfirm: (date) {
          setState(() {
            birthDate = date;
          });
        }, currentTime: DateTime.now(), locale: LocaleType.ar);
  }
  updateAccountAction(){
    if(widget.userInfo.id == "guest"){
      return ;
    }
    Map<String, dynamic> tempData = {};
    if(
    nameController.text == "" &&
        phoneController.text == "" &&
        emailController.text == "" &&
        passController.text == "" &&
        male != widget.userInfo.female &&
        birthDate == null
    ){
      Toast.show("empty fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      return ;
    }else{
      if(nameController.text != ""){
        tempData["name"] = nameController.text;
      }
      if(phoneController.text != ""){
        tempData["phone"] = phoneController.text;
      }
      if(emailController.text != ""){
        tempData["email"] = emailController.text;
      }
      if(passController.text != ""){
        tempData["password"] = passController.text;
      }
      if(male != widget.userInfo.female){
        tempData["female"] = !male;
      }
      if(birthDate != null){
        tempData["birthDate"] = birthDate;
      }
      FirebaseFirestore.instance.collection("users").doc(widget.userInfo.id).update(tempData).then((value) {
        Toast.show("updated", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      });
    }

  }
}
