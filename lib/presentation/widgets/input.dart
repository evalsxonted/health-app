import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  final String prefixIcon;
  final String suffixIcon;
  final String suffixIcon2;
  final String hintText;
  final Function suffixIconFunction;
  final Function suffixIconFunction2;
  final TextEditingController controller;
  final bool readOnly;
  final Function onTab;
  const MyInput(
      {Key key,
      this.prefixIcon,
        this.suffixIcon,
      this.onTab,
      this.suffixIcon2,
      this.hintText,
      this.suffixIconFunction,
      this.suffixIconFunction2,
      this.controller,
      this.readOnly})
      : super(key: key);

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  String currentSuffix;

  @override
  void initState() {
    currentSuffix = widget.suffixIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
              width: 10,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(widget.prefixIcon),fit: BoxFit.fill),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 10, bottom: 10),
            //   child: Image.asset(
            //     widget.prefixIcon,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            suffixIcon: currentSuffix != null
                ? InkWell(
                    child: Image.asset(
                      currentSuffix,
                      scale: 3.5,
                    ),
                    onTap: () {
                      if (widget.suffixIcon2 != null) {
                        if (currentSuffix == widget.suffixIcon2) {
                          setState(() {
                            currentSuffix = widget.suffixIcon;
                            widget.suffixIconFunction2();
                          });
                        } else {
                          setState(() {
                            currentSuffix = widget.suffixIcon2;
                            widget.suffixIconFunction();
                          });
                        }
                      }else {
                        widget.suffixIconFunction();
                      }
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 14), // you need this
          ),
        ),
      ),
    );
  }
}
