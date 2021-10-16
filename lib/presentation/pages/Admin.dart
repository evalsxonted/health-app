import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/models/pharma_info.dart';
import 'package:healthy/presentation/dialogs/doctor_picker.dart';
import 'package:healthy/presentation/dialogs/map_location.dart';
import 'package:healthy/presentation/dialogs/pharma_center_picker.dart';
import 'package:healthy/presentation/dialogs/profession_picker.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../../models/center_info.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  FirebaseFirestore firestore;

  List<String> professions;

  var scaffoldKey;

  int _selectedIndex;

  bool addNew;

  List<String> branches;

  DoctorInfo newDoctor;

  PharmaInfo newPharma;

  CenterInfo newCenter;

  OfferInfo newOffer;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    _selectedIndex = 3;
    addNew = false;
    scaffoldKey = GlobalKey<ScaffoldState>();
    branches = [
      "العروض",
      "المراكز",
      "الصيدليات",
      "الاطباء",
    ];
    newDoctor = DoctorInfo(
      rating: 0,
      visitors: 0,
    );
    newPharma = PharmaInfo(
      visitors: 0,
      rating: 0,
    );
    newCenter = CenterInfo(
      visitors: 0,
      rating: 0,
    );
    newOffer = OfferInfo(
      rating: 0,
      visitors: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text(branches[_selectedIndex]),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: AdminBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 0
                  ? "assets/icons/offers.png"
                  : "assets/icons/offers2.png",
              height: 35,
              width: 35,
            ),
            label: branches[0],
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? "assets/icons/center.png"
                  : "assets/icons/center2.png",
              height: 35,
              width: 35,
            ),
            label: branches[1],
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 2
                  ? "assets/icons/pharmacy.png"
                  : "assets/icons/pharmacy2.png",
              height: 35,
              width: 35,
            ),
            label: branches[2],
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 3
                  ? "assets/icons/doctor.png"
                  : "assets/icons/doctor2.png",
              height: 35,
              width: 35,
            ),
            label: branches[3],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (v) {
          setState(() {
            addNew = false;
            _selectedIndex = v;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(25)),
        child: IconButton(
            icon: Icon(addNew ? Icons.check : Icons.add),
            onPressed: () {
              if (addNew) {
                switch (_selectedIndex) {
                  case 3:
                    {
                      addNewDoctor();
                      break;
                    }
                  case 2:
                    {
                      addNewPharma();
                      break;
                    }
                  case 1:
                    {
                      addNewCenter();
                      break;
                    }
                  case 0:
                    {
                      addNewOffer();
                      break;
                    }
                  default:
                    {
                      break;
                    }
                }
              } else {
                setState(() {
                  addNew = !addNew;
                });
              }
            }),
      ),
    );
  }

  // ignore: non_constant_identifier_names, missing_return
  Widget AdminBody() {
    switch (_selectedIndex) {
      case 3:
        {
          return addNew
              ? SingleChildScrollView(
                  child: Column(
                    key: Key("doctorAddition"),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newDoctor.name = v;
                          },
                          decoration: InputDecoration(hintText: "اسم الطبيب"),
                        ),
                      ),
                      Padding(

                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            chooseProfession("doctor");
                          },
                          decoration:
                              InputDecoration(hintText: "اختصاص الطبيب"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newDoctor.ticketPrice = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "سعر الكشفية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            uploadImage("doctor");
                          },
                          decoration: InputDecoration(hintText: "صورة الطبيب"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newDoctor.description = v;
                          },
                          decoration: InputDecoration(hintText: "وصف الطبيب"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newDoctor.location = v;
                          },
                          decoration: InputDecoration(hintText: "مكان الطبيب"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newDoctor.phone = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "رقم الهاتف"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newDoctor.workTime = v;
                          },
                          decoration: InputDecoration(hintText: "اوقات العمل"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newDoctor.about = v;
                          },
                          decoration: InputDecoration(hintText: "عن الطبيب"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            getMapLocation("doctor");
                          },
                          decoration: InputDecoration(hintText: "الخريطة"),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              : StreamBuilder(
                  key: Key("doctorStream"),
                  stream: firestore.collection("doctors").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'No Data...',
                        ),
                      );
                    } else {
                      List<DocumentSnapshot> items = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Map tempDoctor = items[index].data();
                          tempDoctor["id"] = items[index].id;
                          DoctorInfo doctorInfo = mapToDoctor(tempDoctor);
                          return InkWell(
                            onLongPress: (){
                              deleteComments(doctorInfo.id);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff1A535C), width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            doctorInfo.image,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctorInfo.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        doctorInfo.profession,
                                        style:
                                            TextStyle(fontSize: 16, height: 1.2),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteOne("doctors", doctorInfo.id);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
        }
      case 2:
        {
          return addNew
              ? SingleChildScrollView(
                  child: Column(
                    key: Key("pharmaAddition"),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newPharma.name = v;
                          },
                          decoration: InputDecoration(hintText: "اسم الصيدلية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            uploadImage("pharma");
                          },
                          decoration:
                              InputDecoration(hintText: "صورة الصيدلية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newPharma.description = v;
                          },
                          decoration: InputDecoration(hintText: "وصف الصيدلية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newPharma.location = v;
                          },
                          decoration:
                              InputDecoration(hintText: "مكان الصيدلية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newPharma.phone = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "رقم الهاتف"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newPharma.workTime = v;
                          },
                          decoration: InputDecoration(hintText: "اوقات العمل"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            chooseDoctors("pharma");
                          },
                          decoration:
                              InputDecoration(hintText: "اطباء الصيدلية"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            getMapLocation("pharma");
                          },
                          decoration: InputDecoration(hintText: "الخريطة"),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              : StreamBuilder(
                  key: Key("pharmaStream"),
                  stream: firestore.collection("pharmas").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'No Data...',
                        ),
                      );
                    } else {
                      List<DocumentSnapshot> items = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Map tempPharma = items[index].data();
                          tempPharma["id"] = items[index].id;
                          PharmaInfo pharmaInfo = mapToPharma(tempPharma);
                          return InkWell(
                            onLongPress: (){
                              deleteComments(pharmaInfo.id);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff1A535C), width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            pharmaInfo.image,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pharmaInfo.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        pharmaInfo.doctorsId.length.toString() +
                                            " اطباء ",
                                        style:
                                            TextStyle(fontSize: 16, height: 1.2),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteOne("pharmas", pharmaInfo.id);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
        }
      case 1:
        {
          return addNew
              ? SingleChildScrollView(
                  child: Column(
                    key: Key("centerAddition"),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newCenter.name = v;
                          },
                          decoration: InputDecoration(hintText: "اسم المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            chooseProfession("center");
                          },
                          decoration:
                              InputDecoration(hintText: "اختصاص المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            uploadImage("center");
                          },
                          decoration: InputDecoration(hintText: "صورة المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newCenter.description = v;
                          },
                          decoration: InputDecoration(hintText: "وصف المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newCenter.location = v;
                          },
                          decoration: InputDecoration(hintText: "مكان المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newCenter.phone = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "رقم الهاتف"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newCenter.workTime = v;
                          },
                          decoration: InputDecoration(hintText: "اوقات العمل"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newCenter.about = v;
                          },
                          decoration: InputDecoration(hintText: "عن المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            chooseDoctors("center");
                          },
                          decoration: InputDecoration(hintText: "اطباء المركز"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            getMapLocation("center");
                          },
                          decoration: InputDecoration(hintText: "الخريطة"),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              : StreamBuilder(
                  key: Key("centerStream"),
                  stream: firestore.collection("centers").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'No Data...',
                        ),
                      );
                    } else {
                      List<DocumentSnapshot> items = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Map tempCenter = items[index].data();
                          tempCenter["id"] = items[index].id;
                          CenterInfo centerInfo = mapToCenter(tempCenter);
                          return InkWell(
                            onLongPress: (){
                              deleteComments(centerInfo.id);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff1A535C), width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            centerInfo.image,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        centerInfo.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        centerInfo.doctorsId.length.toString() +
                                            " اطباء ",
                                        style:
                                            TextStyle(fontSize: 16, height: 1.2),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteOne("centers", centerInfo.id);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
        }
      case 0:
        {
          return addNew
              ? SingleChildScrollView(
                  child: Column(
                    key: Key("offerAddition"),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newOffer.offerName = v;
                          },
                          decoration: InputDecoration(hintText: "اسم العرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            uploadImage("offer");
                          },
                          decoration: InputDecoration(hintText: "صورة العرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newOffer.description = v;
                          },
                          decoration: InputDecoration(hintText: "وصف العرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newOffer.location = v;
                          },
                          decoration: InputDecoration(hintText: "مكان العرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newOffer.oldPrice = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "السعر القديم"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            try {
                              newOffer.newPrice = int.parse(v);
                            } catch (e) {
                              Toast.show("not a valid number", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP);
                            }
                          },
                          decoration: InputDecoration(hintText: "السعر الجديد"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (v) {
                            newOffer.offerTime = v;
                          },
                          decoration: InputDecoration(hintText: "وقت العرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            chooseDoctors("offer");
                          },
                          decoration:
                              InputDecoration(hintText: "الطبيب المزود للعرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            getOfferProvider("pharmas");
                          },
                          decoration: InputDecoration(
                              hintText: "الصيدلية المزودة للعرض"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            getOfferProvider("centers");
                          },
                          decoration:
                              InputDecoration(hintText: "المركز المزود للعرض"),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              : StreamBuilder(
                  key: Key("offerStream"),
                  stream: firestore.collection("offers").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'No Data...',
                        ),
                      );
                    } else {
                      List<DocumentSnapshot> items = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Map tempOffer = items[index].data();
                          tempOffer["id"] = items[index].id;
                          OfferInfo offerInfo = mapToOffer(tempOffer);
                          String providers = "المزود: ";
                          if(offerInfo.providerDoctor != null){
                            providers += " طبيب ";
                          }
                          if(offerInfo.providerCenter != null){
                            providers += " مركز ";
                          }
                          if(offerInfo.providerPharma != null){
                            providers += " صيدلية ";
                          }
                          return InkWell(
                            onLongPress: (){
                              deleteComments(offerInfo.id);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff1A535C), width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            offerInfo.image,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offerInfo.offerName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        providers,
                                        style:
                                            TextStyle(fontSize: 16, height: 1.2),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteOne("centers", offerInfo.id);
                                      },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
        }
    }
  }


  getMapLocation(String branch) async {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MapDialog();
      },
    ).then((mapUrl) {
      if (mapUrl != null && mapUrl.indexOf("@") != -1) {
        log(mapUrl);
        var mapDetails = mapUrl.substring(mapUrl.indexOf("@") + 1);
        var cordinate1 = mapDetails.substring(0, mapDetails.indexOf(","));
        var cordinate2 = mapDetails.substring(cordinate1.length + 1);
        cordinate2 = cordinate2.substring(0, cordinate2.indexOf(","));
        switch (branch) {
          case "doctor":
            {
              newDoctor.map =
                  cordinate1.toString() + ", " + cordinate2.toString();
              break;
            }
          case "pharma":
            {
              newPharma.map =
                  cordinate1.toString() + ", " + cordinate2.toString();
              break;
            }
          case "center":
            {
              newCenter.map =
                  cordinate1.toString() + ", " + cordinate2.toString();
              break;
            }
        }
      }
    });
  }

  uploadImage(String branch) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      Toast.show("not a valid image", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    Toast.show("uploading...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    var img = File(pickedFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    var uniqueName =
        Uuid().v1() + img.path.substring(img.path.lastIndexOf("."));
    log(uniqueName);
    var storageReference = storage.ref().child(uniqueName);
    await storageReference.putFile(img);
    switch (branch) {
      case "doctor":
        {
          newDoctor.image = await storageReference.getDownloadURL();
          break;
        }
      case "pharma":
        {
          newPharma.image = await storageReference.getDownloadURL();
          break;
        }
      case "center":
        {
          newCenter.image = await storageReference.getDownloadURL();
          break;
        }
      case "offer":
        {
          newOffer.image = await storageReference.getDownloadURL();
          break;
        }
    }
    Toast.show("image uploaded", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  addNewDoctor() async {
    if (newDoctor.name == null ||
        newDoctor.map == null ||
        newDoctor.about == null ||
        newDoctor.workTime == null ||
        newDoctor.phone == null ||
        newDoctor.location == null ||
        newDoctor.description == null ||
        newDoctor.image == null ||
        newDoctor.ticketPrice == null ||
        newDoctor.profession == null) {
      Toast.show("empty fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("uploading", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      firestore.collection("doctors").add(newDoctor.doctorToMap());
      Toast.show("done", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      setState(() {
        addNew = !addNew;
      });
    }
  }

  addNewPharma() async {
    if (newPharma.name == null ||
        newPharma.map == null ||
        newPharma.workTime == null ||
        newPharma.phone == null ||
        newPharma.location == null ||
        newPharma.doctorsId == null ||
        newPharma.description == null ||
        newPharma.image == null) {
      Toast.show("empty fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("uploading", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      firestore.collection("pharmas").add(newPharma.pharmaToMap());
      Toast.show("done", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      setState(() {
        addNew = !addNew;
      });
    }
  }

  addNewCenter() async {
    if (newCenter.name == null ||
        newCenter.map == null ||
        newCenter.workTime == null ||
        newCenter.phone == null ||
        newCenter.location == null ||
        newCenter.doctorsId == null ||
        newCenter.description == null ||
        newCenter.about == null ||
        newCenter.profession == null ||
        newCenter.image == null) {
      Toast.show("empty fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("uploading", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      firestore.collection("centers").add(newCenter.centerToMap());
      Toast.show("done", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      setState(() {
        addNew = !addNew;
      });
    }
  }

  addNewOffer() async {
    if (newOffer.location == null ||
        newOffer.description == null ||
        newOffer.image == null ||
        (newOffer.providerCenter == null &&
            newOffer.providerCenter == null &&
            newOffer.providerCenter == null) ||
        newOffer.offerTime == null ||
        newOffer.newPrice == null ||
        newOffer.oldPrice == null ||
        newOffer.offerName == null) {
      Toast.show("empty fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("uploading", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      firestore.collection("offers").add(newOffer.offerToMap());
      Toast.show("done", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      setState(() {
        addNew = !addNew;
      });
    }
  }

  deleteOne(String branch, String id) async {
    await firestore.collection(branch).doc(id).delete();
    Toast.show("deleted", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
  }

  chooseDoctors(String branch) async {
    showDialog<List<String>>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return DoctorPicker();
      },
    ).then((doctorsId) {
      if (doctorsId != null) {
        switch (branch) {
          case "pharma":
            {
              newPharma.doctorsId = doctorsId;
              break;
            }
          case "center":
            {
              newCenter.doctorsId = doctorsId;
              break;
            }
          case "offer":
            {
              if (doctorsId.length != 0) newOffer.providerDoctor = doctorsId[0];
              break;
            }
        }
      }
    });
  }

  getOfferProvider(String branch) async {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PharmaCenterPicker(
          branch: branch,
        );
      },
    ).then((providerId) {
      if (providerId != null) {
        switch (branch) {
          case "pharmas":
            {
              newOffer.providerPharma = providerId;
              break;
            }
          case "centers":
            {
              newOffer.providerCenter = providerId;
              break;
            }
        }
      }
    });
  }

  chooseProfession(String branch) async {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ProfessionPicker(branch: branch);
      },
    ).then((profession) {
      if (profession != null) {
        switch (branch) {
          case "doctor":
            {
              newDoctor.profession = profession;
              break;
            }
          case "center":
            {
              newCenter.profession = profession;
              break;
            }
          case "offer":
            {
              newOffer.profession = profession;
              break;
            }

        }
      }
    });
  }

  deleteComments(String providerId){
    firestore.collection("comments").where("providerId", isEqualTo: providerId).get().then((value){
      value.docs.forEach((element) {
        firestore.collection("comments").doc(element.id).delete();
      });
      Toast.show("deleting...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    });
  }
}
