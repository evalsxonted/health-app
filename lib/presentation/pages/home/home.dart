import 'package:flutter/material.dart';
import 'package:healthy/presentation/pages/home/home_constants.dart';
import 'package:healthy/presentation/pages/home/home_widgets/home_bottom_bar.dart';
import 'package:healthy/presentation/pages/home/home_widgets/home_sections.dart';
import 'package:healthy/presentation/pages/home/home_widgets/provinces_appbar.dart';
import 'package:healthy/presentation/pages/home/home_widgets/search_appbar.dart';
import 'package:healthy/utilities/firestore_handler.dart';
import 'package:healthy/utilities/singletons.dart';
import 'home_widgets/home_centers.dart';
import 'home_widgets/home_doctors.dart';
import 'home_widgets/home_drawer.dart';
import 'package:healthy/models/center_info.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/models/offer_info.dart';
import 'package:healthy/models/pharma_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_widgets/home_offers.dart';
import 'home_widgets/home_pharmas.dart';
import 'home_widgets/line.dart';

class Home extends StatefulWidget {
  final UserInfo userInfo;

  const Home({Key key, this.userInfo}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore firestore;
  bool searchOpen;
  String orderBySelected;
  HomeConstants homeConstants;
  String selectedProvince;
  int _selectedIndex;
  List<DoctorInfo> doctors;
  List<PharmaInfo> pharmas;
  List<CenterInfo> centers;
  List<OfferInfo> offers;
  FirestoreHandler firestoreHandler;

  @override
  void initState() {
    firestoreHandler = FirestoreHandler();
    homeConstants = HomeConstants();
    firestore = FirestoreInstance.call;
    doctors = [];
    pharmas = [];
    centers = [];
    offers = [];
    initializeBranches();
    orderBySelected = "تلقائي";
    searchOpen = false;
    _selectedIndex = 3;
    selectedProvince = homeConstants.provinces[0];
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xffE5E5E5),
      appBar: searchOpen
          ? SearchAppBar(
              openSearchFunction: searchAction,
              searchFunction: toggleSearch,
            )
          : ProvincesAndOrderAppBar(
              changeOrderBy: changeOrderBy,
              changeProvince: changeProvinceAction,
              openDrawer: openDrawer,
              openSearch: openSearch,
              orderBySelected: orderBySelected,
              selectedProvince: selectedProvince,
            ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 20),
              child: Text(
                homeConstants.branches[_selectedIndex],
                style: TextStyle(
                    fontSize: 22, color: Theme.of(context).primaryColor),
              ),
            ),
            HLine(),
            HomeSections(
              onSectionTapped: onSectionTapped,
            ),
            Builder(
              builder: (context) {
                switch (_selectedIndex) {
                  //doctor
                  case 3:
                    return HomeDoctors();
                  case 2:
                    return HomePharmas();
                  case 1:
                    return HomeCenters();
                  case 0:
                    return HomeOffers();
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomBar(
        onSelect: onBottomBarItemSelected,
        selectedIndex: _selectedIndex,
      ),
      endDrawer: HomeDrawer(
        userInfo: widget.userInfo,
      ),
    );
  }

  void initializeBranches() {
    firestoreHandler.getDoctors().then((value) => setState(() {
          doctors = value;
        }));
    firestoreHandler.getPharmas().then((value) => setState(() {
          pharmas = value;
        }));
    firestoreHandler.getCenters().then((value) => setState(() {
          centers = value;
        }));
    firestoreHandler.getOffers().then((value) => setState(() {
          offers = value;
        }));
  }

  searchAction(v) {
    switch (_selectedIndex) {
      case 3:
        {
          firestoreHandler.searchDoctors(v).then((value) => setState(() {
                doctors = value;
              }));
          break;
        }
      case 2:
        {
          firestoreHandler.searchPharmas(v).then((value) => setState(() {
                pharmas = value;
              }));
          break;
        }
      case 1:
        {
          firestoreHandler.searchCenters(v).then((value) => setState(() {
                centers = value;
              }));
          break;
        }
      case 0:
        {
          firestoreHandler.searchOffers(v).then((value) => setState(() {
                offers = value;
              }));
          break;
        }
    }
  }

  changeProvinceAction(v) {
    switch (_selectedIndex) {
      case 3:
        {
          List<DoctorInfo> tempList = [];
          if (v == "الكل" || doctors.length == 0) {
            firestoreHandler.getDoctors().then((value) => setState(() {
              doctors = value;
            }));
          } else {
            doctors.forEach((element) {
              if (element.location.contains(v)) {
                tempList.add(element);
              }
            });
            setState(() {
              doctors = tempList;
            });
          }
          break;
        }
      case 2:
        {
          List<PharmaInfo> tempList = [];
          if (v == "الكل" || pharmas.length == 0) {
            firestoreHandler.getPharmas().then((value) => setState(() {
              pharmas = value;
            }));
          } else {
            pharmas.forEach((element) {
              if (element.location.contains(v)) {
                tempList.add(element);
              }
            });
            setState(() {
              pharmas = tempList;
            });
          }
          break;
        }
      case 1:
        {
          List<CenterInfo> tempList = [];
          if (v == "الكل" || centers.length == 0) {
            firestoreHandler.getCenters().then((value) => setState(() {
              centers = value;
            }));
          } else {
            centers.forEach((element) {
              if (element.location.contains(v)) {
                tempList.add(element);
              }
            });
            setState(() {
              centers = tempList;
            });
          }
          break;
        }
      case 0:
        {
          List<OfferInfo> tempList = [];
          if (v == "الكل" || offers.length == 0) {
            firestoreHandler.getOffers().then((value) => setState(() {
              offers = value;
            }));
          } else {
            offers.forEach((element) {
              if (element.location.contains(v)) {
                tempList.add(element);
              }
            });
            setState(() {
              offers = tempList;
            });
          }
          break;
        }
    }
  }

  toggleSearch() {
    setState(() {
      searchOpen = false;
    });
  }

  openDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  openSearch() {
    setState(() {
      searchOpen = true;
    });
  }

  changeOrderBy(String value) {
    orderBySelected = value;
    switch (_selectedIndex) {
      case 3:
        {
          if (value == "تلقائي") {
            firestoreHandler.getDoctors().then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الابجدية") {
            firestoreHandler.orderDoctors("name", false).then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الاقل سعرا") {
            firestoreHandler.orderDoctors("ticketPrice", false).then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الاعلى سعرا") {
            firestoreHandler.orderDoctors("ticketPrice", true).then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "اعدد الزائرين") {
            firestoreHandler.orderDoctors("visitors", true).then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الاكثر تقييما") {
            firestoreHandler.orderDoctors("rating", true).then((value) => setState(() {
              doctors = value;
            }));
          }
          break;
        }
      case 2:
        {
          if (value == "تلقائي") {
            firestoreHandler.getDoctors().then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الابجدية") {
            firestoreHandler.orderPharmas("name", false).then((value) => setState(() {
              pharmas = value;
            }));
          }
          if (value == "الاقل سعرا") {
            firestoreHandler.getDoctors().then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "الاعلى سعرا") {
            firestoreHandler.getDoctors().then((value) => setState(() {
              doctors = value;
            }));
          }
          if (value == "اعدد الزائرين") {
            firestoreHandler.orderPharmas("visitors", true).then((value) => setState(() {
              pharmas = value;
            }));
            }
          if (value == "الاكثر تقييما") {
            firestoreHandler.orderPharmas("rating", true).then((value) => setState(() {
              pharmas = value;
            }));
          }
          break;
        }
      case 1:
        {
          if (value == "تلقائي") {
            firestoreHandler.getCenters().then((value) => setState(() {
              centers = value;
            }));
          }
          if (value == "الابجدية") {
            firestoreHandler.orderCenters("name", false).then((value) => setState(() {
              centers = value;
            }));
          }
          if (value == "الاقل سعرا") {
            firestoreHandler.getCenters().then((value) => setState(() {
              centers = value;
            }));
          }
          if (value == "الاعلى سعرا") {
            firestoreHandler.getCenters().then((value) => setState(() {
              centers = value;
            }));
          }
          if (value == "اعدد الزائرين") {
            firestoreHandler.orderCenters("visitors", true).then((value) => setState(() {
              centers = value;
            }));
          }
          if (value == "الاكثر تقييما") {
            firestoreHandler.orderCenters("rating", true).then((value) => setState(() {
              centers = value;
            }));
          }
          break;
        }
      case 0:
        {
          if (value == "تلقائي") {
            firestoreHandler.getOffers().then((value) => setState(() {
              offers = value;
            }));
          }
          if (value == "الابجدية") {
            firestoreHandler.orderOffers("offerName", false).then((value) => setState(() {
              offers = value;
            }));
          }
          if (value == "الاقل سعرا") {
            firestoreHandler.orderOffers("newPrice", false).then((value) => setState(() {
              offers = value;
            }));
          }
          if (value == "الاعلى سعرا") {
            firestoreHandler.orderOffers("newPrice", true).then((value) => setState(() {
              offers = value;
            }));
          }
          if (value == "اعدد الزائرين") {
            firestoreHandler.orderOffers("visitors", true).then((value) => setState(() {
              offers = value;
            }));
          }
          if (value == "الاكثر تقييما") {
            firestoreHandler.orderOffers("rating", true).then((value) => setState(() {
              offers = value;
            }));
          }
          break;
        }
    }
  }

  onBottomBarItemSelected(int v) {
    setState(() {
      _selectedIndex = v;
    });
  }

  onSectionTapped(int index) {
    if (_selectedIndex == 3) {
      List<DoctorInfo> tempDoctors = [];
      if (homeConstants.doctorProfessions[index] ==
          homeConstants.doctorProfessions[0]) {
        firestoreHandler.getDoctors().then((value) => setState(() {
          doctors = value;
        }));
      } else {
        firestore
            .collection("doctors")
            .where("profession",
                isEqualTo: homeConstants.doctorProfessions[index])
            .get()
            .then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            Map tempMap = value.docs[i].data();
            tempMap["id"] = value.docs[i].id;
            tempDoctors.add(mapToDoctor(tempMap));
          }
          setState(() {
            doctors = tempDoctors;
          });
        });
      }
    }
    if (_selectedIndex == 0) {
      List<OfferInfo> tempOffers = [];
      if (homeConstants.offerProfessions[index] ==
          homeConstants.offerProfessions[0]) {
        firestoreHandler.getOffers().then((value) => setState(() {
          offers = value;
        }));
      } else {
        firestore
            .collection("offers")
            .where("profession",
                isEqualTo: homeConstants.offerProfessions[index])
            .get()
            .then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            Map tempMap = value.docs[i].data();
            tempMap["id"] = value.docs[i].id;
            tempOffers.add(mapToOffer(tempMap));
          }
          setState(() {
            offers = tempOffers;
          });
        });
      }
    }
  }
}
