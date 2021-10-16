import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthy/presentation/widgets/input.dart';
import 'Admin.dart';
import 'home/home.dart';
import 'package:healthy/models/user-info.dart';
import 'signup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseFirestore firestore;
  TextEditingController nameController;
  TextEditingController passController;
  String password;
  bool hidePasswordEnabled;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    nameController = new TextEditingController();
    passController = new TextEditingController();
    password = "";
    hidePasswordEnabled = false;
    passController.addListener(() {
      if (hidePasswordEnabled) {
        password += passController.text.replaceAll("*", "");
        String temp = "";
        for (int i = 0; i < password.length; i++) {
          temp += "*";
        }
        passController.text = temp;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 320,
                  height: 220,
                  margin: EdgeInsets.all(50),
                  child: Image.asset("assets/login.png")),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/person.png",
                    controller: nameController,
                    hintText: "البريد الالكتروني",
                  )),
              Container(
                  margin: EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  child: MyInput(
                    prefixIcon: "assets/icons/pass.png",
                    controller: passController,
                    hintText: "كلمة السر",
                    suffixIcon: "assets/icons/hide_pass.png",
                    suffixIconFunction: () {
                      hidePasswordEnabled = true;
                    },
                    suffixIcon2: "assets/icons/unhide_pass.png",
                    suffixIconFunction2: () {
                      hidePasswordEnabled = false;
                      passController.text = password;
                      password = "";
                    },
                  )),
              InkWell(
                onTap: loginAction,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
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
                      "تسجيل الدخول",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    "هل نسيت كلمة السر؟",
                    style: TextStyle(fontSize: 12),
                  )),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/line.png",
                      width: 80,
                      fit: BoxFit.fitHeight,
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Text("او سجل عن طريق"),
                    ),
                    Image.asset(
                      "assets/line.png",
                      width: 80,
                      fit: BoxFit.fitHeight,
                      height: 2,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _facebookLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 1))
                            ]),
                        child: Image.asset(
                          "assets/icons/facebook.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _googleLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 1))
                            ]),
                        child: Image.asset(
                          "assets/icons/google.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          "سجل الان",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Signup()));
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("لا تملك حساب؟"),
                    ],
                  ),),
              InkWell(
                child: Text(
                  "الدخول كضيف",
                ),
                onTap: guestLogin,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<String> _facebookLogin() async {
    var userData;
    var result = await FacebookAuth.instance.login();
    if (result != null) {
      userData = await FacebookAuth.instance.getUserData();
      firestore
          .collection("users")
          .where("facebook", isEqualTo: userData["id"])
          .get()
          .then((value) async {
        if (value.docs.length > 0) {
          Box prefsBox = await Hive.openBox("prefs");
          await prefsBox.put("userId", value.docs[0].id);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Home(
                    userInfo: mapToUserInfo(value.docs[0].data()),
                  )));
        } else {
          await firestore.collection("users").add({
            "name": userData["name"],
            "email": userData["email"],
            "facebook": userData["id"],
          }).then((value) async {
            Box prefsBox = await Hive.openBox("prefs");
            await prefsBox.put("userId", value.id);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    Home(
                      userInfo: UserInfo(
                        name: userData["name"],
                        email: userData["email"],
                        facebook: userData["id"],
                      ),
                    )));
          });
        }
      });
    } else {
      Toast.show("not accepted", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }
  _googleLogin() async {
    GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.email',
      ],
    ).signIn().then((value) {
      if(value != null){
        var userData = {
          "google": value.id,
          "name": value.displayName,
          "email": value.email,
        };
        firestore
            .collection("users")
            .where("google", isEqualTo: userData["google"])
            .get()
            .then((value) async {
          if (value.docs.length > 0) {
            Box prefsBox = await Hive.openBox("prefs");
            await prefsBox.put("userId", value.docs[0].id);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    Home(
                      userInfo: mapToUserInfo(value.docs[0].data()),
                    )));
          } else {
            await firestore.collection("users").add({
              "name": userData["name"],
              "email": userData["email"],
              "google": userData["google"],
            }).then((value) async {
              Box prefsBox = await Hive.openBox("prefs");
              await prefsBox.put("userId", value.id);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Home(
                        userInfo: UserInfo(
                          name: userData["name"],
                          email: userData["email"],
                          google: userData["google"],
                        ),
                      )));
            });
          }
        });
      }else{
        Toast.show("not accepted", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    }).catchError((e){
      Toast.show("not accepted", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    });
  }
  loginAction(){
    String loginName = nameController.text;
    String loginPass = password == "" ? passController.text : password;
    if(loginName == "" || loginPass == ""){
      Toast.show("Empty Fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      return;
    }
    if (loginName == "admin" &&
        loginPass == "password") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Admin()));
    }else{
      Toast.show("loading...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      firestore
          .collection("users")
          .where("email", isEqualTo: loginName)
          .get().then((value) async {
        if(value.size == 0){
          Toast.show("user not found", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        }else{
          if(value.docs[0].data()["password"] != loginPass){
            Toast.show("wrong password", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }else{
            Box prefsBox = await Hive.openBox("prefs");
            await prefsBox.put("userId", value.docs[0].id);
            Map userData = value.docs[0].data();
            userData["id"] = value.docs[0].id;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    Home(
                      userInfo: mapToUserInfo(userData),
                    )));
          }
        }
      });
    }
  }
  guestLogin() async {
    Toast.show("loading...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    Box prefsBox = await Hive.openBox("prefs");
    await prefsBox.put("userId", "guest");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            Home(
              userInfo: mapToUserInfo({
                "name": "guest",
                "email": "guest",
                "password": "password",
                "id":"guest",
              }),
            )));
  }
}