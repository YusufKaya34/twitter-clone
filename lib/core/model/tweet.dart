import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter/core/model/user_model.dart';

class Tweet {
  final String? userID;
  final String? text;
  final Timestamp? date;
  MyUser? user;

  Tweet({this.userID, this.text, this.date});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'text': text,
      'date': date ?? FieldValue.serverTimestamp(),
    };
  }

  Tweet.fromMap(
    Map<String, dynamic> map,
  )   : userID = map['userID'],
        text = map['text'],
        date = map['date'];

  @override
  String toString() {
    return 'Tweet{userID=$userID,text=$text}';
  }
}
