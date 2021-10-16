import 'package:flutter/material.dart';
import 'package:healthy/presentation/pages/login.dart';
import 'package:healthy/presentation/widgets/dialog_action_button.dart';
import 'package:healthy/presentation/widgets/dialog_cancel_button.dart';
import 'package:hive/hive.dart';

class Logout extends StatelessWidget {
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
          "هل انت متأكد؟",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: Colors.black,
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialogAction(
                function: () => logoutAction(context),
                text: "تاكيد",
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

  logoutAction(BuildContext context) async {
    Box prefsBox = await Hive.openBox("prefs");
    await prefsBox.clear();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Login(),
    ));
  }
}
