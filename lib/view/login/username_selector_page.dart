import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';

import 'package:twitter/view/constants/buttons.dart';
import 'package:twitter/view/constants/changeable_alert_dialog.dart';
import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/home/home_page.dart';

class UsernameSelectorPage extends StatelessWidget {
  UsernameSelectorPage({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.appBarIcon(),
        body: columnBuildWidget(context),
      ),
    );
  }

  Padding columnBuildWidget(BuildContext context) {
    return Padding(
      padding: Constants.usernamePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 2,
          ),
          Text(
            LocaleKeys.login_usernameText.locale,
            style: Constants.hesabiniOlusturFont(),
          ),
          Spacer(),
          Text(
            LocaleKeys.login_usernameText2.locale,
            style: TextStyle(
                fontFamily: 'Cantarell.ttf',
                color: Colors.grey.shade700,
                fontSize: 17),
          ),
          SizedBox(
            height: 15,
          ),
          formBuildWidget(context),
          Spacer(
            flex: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: Buttons.ileriButton2(context, () {
                  _userNameSelect(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form formBuildWidget(context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 10, right: MediaQuery.of(context).size.width / 12),
            child: TextFormField(
              validator: (value) {
                return value!.length >= 5
                    ? null
                    : LocaleKeys.login_nameAtLeast.locale;
              },
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: LocaleKeys.login_name.locale,
                  labelStyle: Constants.signInTextStyle(),
                  border: Constants.myOutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10, right: MediaQuery.of(context).size.width / 12),
            child: TextFormField(
              validator: (value) {
                return value!.length >= 6
                    ? null
                    : LocaleKeys.login_usernameAtLeast.locale;
              },
              controller: _userNameController,
              decoration: InputDecoration(
                  labelText: LocaleKeys.login_usernameText3.locale,
                  labelStyle: Constants.signInTextStyle(),
                  border: Constants.myOutlineInputBorder()),
            ),
          )
        ],
      ),
    );
  }

  void _userNameSelect(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    _userModel.user;
    if (_userNameController.text.length >= 6 &&
        _nameController.text.length >= 5) {
            await _userModel.currentUser();
      await _userModel.getAllUser();
          
      await _userModel.createUserName(
          _userModel.user!.userID!, _userNameController.text);
            await _userModel.currentUser();
      await _userModel.getAllUser();
      await _userModel.createName(
          _userModel.user!.userID!, _nameController.text);
      await _userModel.currentUser();
      await _userModel.getAllUser();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
      await _userModel.currentUser();
    } else {
      showDialog(
          context: context,
          builder: (builder) => ChangeableAlertDialog(
              baslik: LocaleKeys.login_usernameError.locale,
              icerik: LocaleKeys.login_usernameError2.locale,
              anaButonYazisi: LocaleKeys.login_okay.locale));
    }
  }
}
