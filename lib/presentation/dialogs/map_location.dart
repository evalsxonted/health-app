import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healthy/presentation/widgets/dialog_action_button.dart';
import 'package:healthy/presentation/widgets/dialog_cancel_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapDialog extends StatefulWidget {
  @override
  _MapDialogState createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  WebViewController myController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      backgroundColor: Color(0xfff5f5f5),
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text("اختر المكان المطلوب", textDirection: TextDirection.rtl,style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
      ),
      content: Container(
        child: WebView(
          gestureRecognizers: Platform.isAndroid ? {Factory(() => EagerGestureRecognizer())} : null,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://www.google.com/maps/',
          onWebViewCreated: (WebViewController webcontroller){
            myController = webcontroller;
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
                function: saveAction,
                text: "حفظ",
              ),
              SizedBox(width: 30,),
              DialogCancel(),
            ],
          ),
        )
      ],

    );
  }

  saveAction(){
    myController.currentUrl().then((value) {
      Navigator.of(context).pop(value);
    });
  }
}
