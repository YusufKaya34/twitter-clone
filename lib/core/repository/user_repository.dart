// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:twitter/core/model/mesaj.dart';
import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/services/auth_base.dart';
import 'package:twitter/core/services/fake_auth_services.dart';
import 'package:twitter/core/services/firebase_auth_service.dart';
import 'package:twitter/core/services/firebase_storage_service.dart';
import 'package:twitter/core/services/firestore_db_service.dart';
import 'package:twitter/core/services/locator.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  final FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  final FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();

  AppMode appMode = AppMode.RELEASE;
  @override
  Future<MyUser?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      MyUser? _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _firestoreDBService.readUser(_user.userID!);
      }
    }
    return null;
  }
  

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<MyUser?> singInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.singInAnonymously();
    } else {
      return await _firebaseAuthService.singInAnonymously();
    }
  }

/*  @override
  Future<MyUser?> singInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.singInWithGoogle();
    } else {
      MyUser? myUser = await _firebaseAuthService.singInWithGoogle();
      print('${myUser!.userID}');
      bool sonuc = await _firestoreDBService.saveUser(myUser);

      if (sonuc) {
        return myUser;
      } else {
        return null;
      }
    }
  }*/

  @override
  Future<MyUser?> signInEmailAndPassword(String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInEmailAndPassword(
          email, password);
    } else {
      return await _firebaseAuthService.signInEmailAndPassword(email, password);
    }
  }

  @override
  Future<MyUser?> signUp(
    String email,
    String password,
  ) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signUp(
        email,
        password,
      );
    } else {
      MyUser? myUser = await _firebaseAuthService.signUp(
        email,
        password,
      );
      print('${myUser!.userID}');
      bool sonuc = await _firestoreDBService.saveUser(myUser);

      if (sonuc) {
        return myUser;
      } else {
        return null;
      }
    }
  }

  Future createUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.createUserName(userID, yeniUserName);
      
    }
  }

  Future<bool> createName(String userID, String yeniName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.createName(userID, yeniName);
    }
  }

 

  Future<List<MyUser>> getAllUser() async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      var tumKullaniciListesi = await _firestoreDBService.getAllUser();
      return tumKullaniciListesi;
    }
  }



  Future updateUserName(String? userID, String newUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.updateUserName(userID, newUserName);
    }
  }

  Future<String> uploadFile(
      String? userID, String fileType, File? profilePic) async {
    if (appMode == AppMode.DEBUG) {
      return 'download_url';
    } else {
      var profilePicURL = await _firebaseStorageService.uploadFile(
          userID!, fileType, profilePic!);
      await _firestoreDBService.updateProfilePic(userID, profilePicURL);
      return profilePicURL;
    }
  }

  Stream<List<Mesaj>> getMessages(String currentUserID, String chattingUserID) {
    if (appMode == AppMode.DEBUG) {
      return const Stream.empty();
    } else {
      return _firestoreDBService.getMessages(currentUserID, chattingUserID);
    }
  }

  Future saveMessage(Mesaj savedMessage)async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreDBService.saveMessage(savedMessage);
    }
  }

  Future<List<Tweet>> getTweets(String currentUserID) async{
      if (appMode == AppMode.DEBUG) {
      return Future.value([]);
    } else {
      return await _firestoreDBService.getTweets(currentUserID, );
    }
  }

  Future saveTweet(Tweet savedTweet) async{
        if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreDBService.saveTweet(savedTweet);
    }
  }
  
  @override
 Future sendPasswordResetEmail(String email)async {
     if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return await _firebaseAuthService.sendPasswordResetEmail(email);
    }
  }
}
