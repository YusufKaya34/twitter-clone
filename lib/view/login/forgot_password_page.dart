import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';

import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/buttons.dart';
import 'package:twitter/view/constants/changeable_alert_dialog.dart';
import 'package:twitter/view/constants/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  TextEditingController? controller;
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.appBarIcon(),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: buildColumnWidget(context),
        ));
  }

  Padding buildColumnWidget(BuildContext context) {
    return Padding(
          padding: Constants.logInPagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                LocaleKeys.login_forgotPasswordPage.locale,
                style: Constants.forgotPasswordHeadlineTextStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(LocaleKeys.login_forgotPasswordPage2.locale,
                  style: Constants.forgotPasswordTextStyle()),
              buildTextFormFieldWidget(),
              const Spacer(
                flex: 7,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5, bottom: 5),
                child: Buttons.ileriButton2(context, () {
                  _formSubmit(context, email);
                }),
              ),
            ],
          ),
        );
  }

  Padding buildTextFormFieldWidget() {
    return Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return value!.contains('.com')
                        ? null
                        : LocaleKeys.login_emailCheckText.locale;
                  },
                  decoration: InputDecoration(
                      labelText: LocaleKeys.login_email.locale,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: Constants.boldFont().fontFamily),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              );
  }

  _formSubmit(context, String email) async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    var passwordReset = await _userModel.sendPasswordResetEmail(email);
    if (passwordReset == true) {
// gri baloncuk ile sıfırlama linki gönderildi denilecek
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (builder) => ChangeableAlertDialog(
              baslik: LocaleKeys.login_error.locale,
              icerik: LocaleKeys.login_emailCheckText.locale,
              anaButonYazisi: LocaleKeys.login_okay.locale));
    }
  }
}
