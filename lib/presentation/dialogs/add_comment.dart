import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy/models/comment_info.dart';
import 'package:healthy/presentation/widgets/comment_input.dart';
import 'package:healthy/presentation/widgets/dialog_action_button.dart';
import 'package:healthy/presentation/widgets/dialog_cancel_button.dart';
import 'package:healthy/utilities/singletons.dart';

class AddComment extends StatefulWidget {
  final String providerId;
  final String userName;
  AddComment({Key key, this.providerId, this.userName}) : super(key: key);
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController commentController =  new TextEditingController();
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text("اضافة تعليق", textDirection: TextDirection.rtl,style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.black,
              ),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 20,
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              CommentInput(
                commentController: commentController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialogAction(
                text: "حفظ",
                function: saveAction,
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
    FirestoreInstance.call.collection("comments").add(Comment(
        providerId: widget.providerId,
        comment: commentController.text,
        date: DateTime.now(),
        userName: widget.userName,
        rating: rating
    ).commentToMap()).then((value) {
      Navigator.of(context).pop();
    });
  }
}
