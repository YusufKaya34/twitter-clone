import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/buttons.dart';
import 'package:twitter/view/constants/changeable_alert_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _controllerUserName = TextEditingController();
  File? _profilePic;
  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context, listen: true);
    _controllerUserName.text = userModel.user!.username!;
    //print("profil sayfasındaki user bilgileri : ${_userModel.user}");
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.homePage_profile.locale),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 160,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: Text(
                                      LocaleKeys.homePage_pickCamera.locale),
                                  onTap: () {
                                    _kameradanFotoCek();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: Text(
                                      LocaleKeys.homePage_pickGallery.locale),
                                  onTap: () {
                                    _galeridenResimSec();
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    // berkan abine ok hatasını ve profil resmi hatasını göster, buraya metotla current user i getir ya da en üstte dene aramalara kullanıcıları getir istersen oradan da mesaja gider onun dışında videolara devam et zaten az kaldı uygulamaya reklam falan eklersin bildirim gönderirsin mesaj geldiğinde, ardından bakacaz
                    backgroundImage: _profilePic == null
                        ? NetworkImage(userModel.user!.iconAdress!)
                        : FileImage(_profilePic as File) as ImageProvider,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: userModel.user?.email,
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: LocaleKeys.homePage_yourEmail.locale,
                    hintText:  LocaleKeys.homePage_yourEmail.locale,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.homePage_yourUsername.locale,
                    hintText: LocaleKeys.homePage_yourUsername.locale,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Buttons.profilePageButton(context, () {
                  _userNameGuncelle(context);
                  _profilFotoGuncelle(context);
                  userModel.currentUser();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _userNameGuncelle(BuildContext context) async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (userModel.user!.username != _controllerUserName.text) {
        await userModel.currentUser();
      await userModel.getAllUser();
      var updateResult = await userModel.updateUserName(
          userModel.user!.userID, _controllerUserName.text);

      userModel.currentUser();
      if (updateResult == true) {
        showDialog(
          context: context,
          builder: (context) {
            return  ChangeableAlertDialog(
              baslik:LocaleKeys.login_successful.locale,
              icerik: LocaleKeys.login_usernameUpdated.locale,
              anaButonYazisi:LocaleKeys.login_okay.locale,
            );
          },
        );
        userModel.currentUser();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            _controllerUserName.text = userModel.user!.username!;
            return  ChangeableAlertDialog(
              baslik:  LocaleKeys.login_error.locale,
              icerik:
                  LocaleKeys.login_usernameNotUpdated.locale,
              anaButonYazisi:  LocaleKeys.login_okay.locale,
            );
          },
        );
        userModel.currentUser();
      }
    }
  }

  void _galeridenResimSec() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    var picker = ImagePicker();
    var response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
        await userModel.currentUser();
      await userModel.getAllUser();
      setState(() {
        _profilePic = File(response.path);
        Navigator.of(context).pop();
      });
      userModel.currentUser();
    } else {
       ChangeableAlertDialog(
          baslik: LocaleKeys.homePage_pickPicture.locale,
          icerik: LocaleKeys.homePage_pleasePickPicture.locale,
          anaButonYazisi: LocaleKeys.login_okay.locale);
    }
  }

  void _kameradanFotoCek() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    var picker = ImagePicker();
    var response = await picker.pickImage(source: ImageSource.camera);

    if (response != null) {
        await userModel.currentUser();
      await userModel.getAllUser();
      setState(() {
        _profilePic = File(response.path);
        Navigator.of(context).pop();
      });
      userModel.currentUser();
    } else {
       ChangeableAlertDialog(
          baslik: LocaleKeys.homePage_shootPicture.locale,
          icerik: LocaleKeys.homePage_pleaseShootPicture.locale,
          anaButonYazisi: LocaleKeys.login_okay.locale);
    }
  }

  _profilFotoGuncelle(BuildContext context) async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (_profilePic != null) {
        await userModel.currentUser();
      await userModel.getAllUser();
      var url = await userModel.uploadFile(
          userModel.user!.userID, "iconAdress", _profilePic);
      showDialog(
        context: context,
        builder: (context) {
          return  ChangeableAlertDialog(
              baslik:  LocaleKeys.login_successful.locale,
              icerik: LocaleKeys.login_profilePicSucceed.locale,
              anaButonYazisi:LocaleKeys.login_okay.locale);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return  ChangeableAlertDialog(
              baslik: LocaleKeys.login_failed.locale,
              icerik: LocaleKeys.login_profilePicError.locale,
              anaButonYazisi: LocaleKeys.login_okay.locale);
        },
      );
    }
  }
}
