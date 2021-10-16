import 'package:flutter/material.dart';
class CommentInput extends StatelessWidget {
  final TextEditingController commentController;

  const CommentInput({Key key, this.commentController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: commentController,
        maxLines: 5,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "اكتب تعليقك هنا",
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(color: Color(0xffc1c1c1)),
        ),),
    );
  }
}
