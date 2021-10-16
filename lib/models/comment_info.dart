class Comment{
  final String comment;
  final double rating;
  final String userName;
  final DateTime date;
  final String providerId;

  Comment({this.comment, this.rating, this.userName, this.date, this.providerId});
  Map<String, dynamic> commentToMap(){
    return {
      "comment" : comment,
      "rating" : rating,
      "userName" : userName,
      "date" : date,
      "providerId" : providerId,
    };
  }
}
Comment mapToComment(Map info){
  return Comment(
    rating: info["rating"],
    userName: info["userName"],
    date: info["date"].toDate(),
    comment: info["comment"],
    providerId: info["providerId"],
  );
}