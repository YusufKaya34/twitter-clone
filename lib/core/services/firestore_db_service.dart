import 'package:twitter/core/model/mesaj.dart';
import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBService implements DB {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(MyUser user) async {
    DocumentSnapshot okunanUser =
        await FirebaseFirestore.instance.doc("users/${user.userID}").get();

    if (okunanUser.data() == null) {
      await _firebaseDB.collection("users").doc(user.userID).set(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<MyUser> readUser(String userID) async {
    DocumentSnapshot okunanUser =
        await _firebaseDB.collection("users").doc(userID).get();

    MyUser okunanUserNesnesi =
        MyUser.fromMap(okunanUser.data() as Map<String, dynamic>);
    return okunanUserNesnesi;
  }

  @override
  Future<bool> createUserName(String userID, String yeniUserName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("username", isEqualTo: yeniUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(userID)
          .update({'username': yeniUserName});
      return true;
    }
  }

  Future<bool> createName(String userID, String yeniName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("name", isEqualTo: yeniName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(userID)
          .update({'name': yeniName});
      return true;
    }
  }

  @override
  Future<List<MyUser>> getAllUser() async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection("users")
        .orderBy("createdAt", descending: true)
        .get();
    List<MyUser> tumKullanicilar = [];
    tumKullanicilar = querySnapshot.docs
        .map((e) => MyUser.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return tumKullanicilar;
  }

  @override
  Future<bool> updateUserName(String? userID, newUserName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("username", isEqualTo: newUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(userID)
          .update({'username': newUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilePic(String userID, String profilePicURL) async {
    await _firebaseDB
        .collection("users")
        .doc(userID)
        .update({'iconAdress': profilePicURL});
    return true;
  }

  @override
  Stream<List<Mesaj>> getMessages(String currentUserID, String chattingUserID) {
    var snapShot = _firebaseDB
        .collection("chats")
        .doc("$currentUserID--$chattingUserID")
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((messageList) =>
        messageList.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
  }

  @override
  Future<bool> saveMessage(Mesaj savedMessage) async {
    var messageID = _firebaseDB.collection('chats').doc().id;
    var docID = '${savedMessage.kimden}--${savedMessage.kime}';
    var receiverDocID = '${savedMessage.kime}--${savedMessage.kimden}';
    var savedMap = savedMessage.toMap();
    await _firebaseDB
        .collection('chats')
        .doc(docID)
        .collection('messages')
        .doc(messageID)
        .set(savedMap);
    savedMap.update('bendenMi', (value) => false);
    await _firebaseDB
        .collection('chats')
        .doc(receiverDocID)
        .collection('messages')
        .doc(messageID)
        .set(savedMap);
    return true;
  }

  @override
  Future<List<Tweet>> getTweets(String currentUserID) async {
    var tweetID = _firebaseDB.collection('tweets').doc().id;
    var tweetSnapshot = await _firebaseDB
        .collection("tweets")
        .orderBy("date", descending: true)
        .get();

    var tweetList =
        tweetSnapshot.docs.map((e) => Tweet.fromMap(e.data())).toList();
    for (var i = 0; i < tweetList.length; i++) {
      var user = await readUser(tweetList[i].userID ?? "ERR");
      tweetList[i].user = user;
    }
    return tweetList;
  }

  @override
  Future saveTweet(Tweet savedTweet) async {
    var tweetID = _firebaseDB.collection('tweets').doc().id;
    var docID = '${savedTweet.userID}';
    var savedMap = savedTweet.toMap();
    await _firebaseDB.collection("tweets").doc(tweetID).set(savedMap);
    return true;
  }
}
