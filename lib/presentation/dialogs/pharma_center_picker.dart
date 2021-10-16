import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/presentation/widgets/add_icon.dart';
import 'package:healthy/presentation/widgets/dialog_action_button.dart';
import 'package:healthy/presentation/widgets/dialog_cancel_button.dart';
import 'package:healthy/presentation/widgets/small_rounded_image.dart';
import 'package:healthy/utilities/singletons.dart';

// ignore: must_be_immutable
class PharmaCenterPicker extends StatelessWidget {
  final String branch;

  PharmaCenterPicker({Key key, this.branch}) : super(key: key);
  String providerId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color(0xfff5f5f5),
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          "حدد مزود الخدمة",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: StreamBuilder(
          stream: FirestoreInstance.call.collection(branch).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Data...',
                ),
              );
            } else {
              List<DocumentSnapshot> items = snapshot.data.docs;
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Map tempDoctor = items[index].data();
                      tempDoctor["id"] = items[index].id;
                      DoctorInfo doctorInfo = mapToDoctor(tempDoctor);
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallRoundedImage(
                              networkImage: doctorInfo.image,
                            ),
                            Flexible(
                              child: Text(
                                doctorInfo.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.2,
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                              ),
                            ),
                            AddIcon(
                              function: () => providerId = doctorInfo.id,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialogAction(
                function: () => Navigator.of(context).pop(providerId),
                text: "حفظ",
              ),
              SizedBox(
                width: 30,
              ),
              DialogCancel(),
            ],
          ),
        )
      ],
    );
  }
}
