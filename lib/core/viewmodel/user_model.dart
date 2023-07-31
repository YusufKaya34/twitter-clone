import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter/core/model/mesaj.dart';
import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/repository/user_repository.dart';
import 'package:twitter/core/services/auth_base.dart';
import 'package:twitter/core/services/locator.dart';

enum ViewState { idle, busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  final UserRepository _userRepository = locator<UserRepository>();
  MyUser? _user;
  String? emailHataMesaji;
  String? isimHataMesaji;
  String? usernameHataMesaji;
  String? birthdayHataMesaji;
  String? passwordHataMesaji;

  MyUser? get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.currentUser();
      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      print('VİEWMODELDEKİ CURRENT USER METHODU HATASI $e');
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  Future<List<MyUser>> getAllUser() async {
    var tumKullaniciListesi = await _userRepository.getAllUser();
    return tumKullaniciListesi;
  }

  @override
  Future<bool> signOut() async {
    try {
      print('çalıştı ');
      state = ViewState.busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      print('VİEWMODELDEKİ SİGN OUT HATASI $e');
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<MyUser?> singInAnonymously() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.singInAnonymously();
      return _user;
    } catch (e) {
      print('VİEWMODELDEKİ SİGN İN ANONYMOUSLY HATASI $e');
    } finally {
      state = ViewState.idle;
    }
    return null;
  }

/*  @override
  Future<MyUser?> singInWithGoogle() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.singInWithGoogle();
      return _user;
    } catch (e) {
      print('VİEWMODELDEKİ SİGN İN WİTH GOOGLE HATA $e');
    } finally {
      state = ViewState.idle;
    }
    return null;
  }*/

  @override
  Future<MyUser?> signInEmailAndPassword(String email, String password) async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signInEmailAndPassword(email, password);
      return _user;
    } catch (e) {
      print('VİEWMODELDEKİ SİGN IN EMAİL AND PASSWORD HATASI $e');
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<MyUser?> signUp(
    String email,
    String password,
  ) async {
    if (_emailPasswordControl(
      email,
      password,
    )) {
      try {
        state = ViewState.busy;
        _user = await _userRepository.signUp(
          email,
          password,
        );
        return _user;
      } finally {
        state = ViewState.idle;
      }
    } else {
      return null;
    }
  }

  bool _emailPasswordControl(
    String email,
    String password,
  ) {
    var sonuc = true;
    if (password.length < 6) {
      passwordHataMesaji = 'En az 6 karakter olmalı';
      sonuc = false;
    } else {
      passwordHataMesaji = null;
    }
    if (!email.contains('@')) {
      emailHataMesaji = 'Geçersiz email adresi';
      sonuc = false;
    } else {
      emailHataMesaji = null;
    }

    return sonuc;
  }

  Future createUserName(String userID, String yeniUserName) async {
    state = ViewState.busy;
    var sonuc = await _userRepository.createUserName(userID, yeniUserName);
    state = ViewState.idle;
    return sonuc;
  }

  Future<bool> createName(String userID, String yeniName) async {
    state = ViewState.busy;
    var sonuc = await _userRepository.createName(userID, yeniName);
    state = ViewState.idle;
    return sonuc;
  }

  Future updateUserName(String? userID, String newUserName) async {
    var sonuc = await _userRepository.updateUserName(userID, newUserName);
    if (sonuc) {
      _user!.username = newUserName;
    }
    return sonuc;
  }

  Future<String> uploadFile(
      String? userID, String fileType, File? profilePic) async {
    var downloadLink =
        await _userRepository.uploadFile(userID, fileType, profilePic);
    return downloadLink;
  }

  Stream<List<Mesaj>> getMessages(String currentUserID, String chattingUserID) {
    return _userRepository.getMessages(currentUserID, chattingUserID);
  }

  Future<List<Tweet>> getTweets(
    String currentUserID,
  ) async{
    return await _userRepository.getTweets(
      currentUserID,
    );
  }

  Future saveMessage(Mesaj savedMessage) async {
    return _userRepository.saveMessage(savedMessage);
  }

  Future saveTweet(Tweet savedTweet) async {
    return _userRepository.saveTweet(savedTweet);
  }

  @override
  Future sendPasswordResetEmail(String email) async {
    state = ViewState.busy;
    var sonuc = await _userRepository.sendPasswordResetEmail(email);
    state = ViewState.idle;
    return sonuc;
  }
}
