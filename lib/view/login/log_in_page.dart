import 'package:flutter/material.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/buttons.dart';

import 'package:twitter/view/constants/changeable_alert_dialog.dart';
import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/login/forgot_password_page.dart';
import 'package:twitter/view/login/log_in_verify_page.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  Future _formSubmit(BuildContext context) async {
    formKey.currentState?.save();
    if (deger.toString().contains('@')) {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => LogInVerifyPage(girilenDeger: deger),
      ));
    } else {
      showDialog(
          context: context,
          builder: (builder) => ChangeableAlertDialog(
              baslik: LocaleKeys.login_alertDialogText1.locale,
              icerik: LocaleKeys.login_emailCheckText.locale,
              anaButonYazisi: LocaleKeys.login_alertDialogText2.locale));
    }
  }

  LogInPage({super.key});
  String deger = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.appBarIcon(),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: Constants.logInPagePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  LocaleKeys.login_signInText.locale,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: Constants.boldFont().fontFamily),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return value!.contains('@')
                          ? null
                          : LocaleKeys.login_emailCheckText.locale;
                    },
                    onSaved: (girilen) {
                      deger = girilen!;
                    },
                    decoration: Constants.textFormFieldDecoration(LocaleKeys.login_signInText2.locale,)
                  ),
                ),
                const Spacer(flex: 9),
                buildRowWidget(context)
              ],
            ),
          ),
        ));
  }

  Padding buildRowWidget(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ));
                      },
                      style: Buttons.logInButtonStyle2(),
                      child: Text(
                        LocaleKeys.login_forgotPass.locale,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.boldFont().fontFamily),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () => _formSubmit(context),
                        style: Buttons.logInButtonStyle(),
                        child: Text(
                          LocaleKeys.login_nextButtonText.locale,
                          style: Constants.logInTextStyle()
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
