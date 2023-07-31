import 'package:twitter/core/model/mesaj.dart';
import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';

abstract class DB {
  Future<bool> saveUser(MyUser user);
  Future<MyUser> readUser(String userID);
  Future createUserName(String userID, String createdUserName);
  Future  updateUserName(String userID, String newUserName);
  Future<List<MyUser>> getAllUser();
  Future updateProfilePic(String userID, String profilePicURL);
  Stream<List> getMessages(String currentUserID,String chattingUserID);
  Future<List> getTweets(String userID,);
  Future saveMessage(Mesaj savedMessage);
  Future saveTweet(Tweet savedTweet);


}
