import 'package:flutter/material.dart';
import 'package:healthy/presentation/widgets/add_icon.dart';
import 'package:healthy/presentation/widgets/dialog_action_button.dart';
import 'package:healthy/presentation/widgets/dialog_cancel_button.dart';

// ignore: must_be_immutable
class ProfessionPicker extends StatelessWidget {
  final String branch;

  ProfessionPicker({Key key, this.branch}) : super(key: key);
  final List<String> centerProfessions = [
    "جميع الاختصاصات",
    "طب الاسنان",
    "اختصاص ليزر",
    "اختصاص الجلدية",
    "طب تجميلي",
    "عناية الشعر",
    "تحاليل",
    "رشاقة",
  ];
  final List<String> doctorProfessions = [
    "اختصاص عام",
    "طبيب الاسنان",
    "طبيب اطفال",
    "طبيب نسائية",
    "طبيب جراح",
    "طبيب باطنية",
    "طبيب جلدية",
    "طبيب تجميل",
    "انف اذن حنجرة",
    "طبيب العيون",
    "طبيب عظام",
    "طبيب اعصاب",
    "طبيب قلبية",
    "طبيب جهاز هضمي",
    "طبيب بولية",
    "طبيب اورام",
    "طبيب امراض دم",
    "طبيب نفسي",
  ];
  String chosenProfession;

  @override
  Widget build(BuildContext context) {
    chosenProfession = branch == "center" ? "جميع الاختصاصات" : "اختصاص عام";
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color(0xfff5f5f5),
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          "حدد الاختصاص",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: branch == "center"? 7 : 18,
          itemBuilder: (context, index) {
            List<String> items =
                branch == "center" ? centerProfessions : doctorProfessions;
            return Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      items[index],
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                  ),
                  AddIcon(
                    function: ()=>chosenProfession = items[index],
                  ),
                ],
              ),
            );
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
                function: ()=>Navigator.of(context).pop(chosenProfession),
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
