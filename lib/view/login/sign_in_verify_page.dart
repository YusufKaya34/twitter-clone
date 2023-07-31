// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/changeable_alert_dialog.dart';

import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/login/log_in_page.dart';
import 'package:twitter/view/login/username_selector_page.dart';

class SignInVerifyPage extends StatefulWidget {
  String? password;
  String? email;
  String? errorText;

  SignInVerifyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInVerifyPage> createState() => _SignInVerifyPageState();
}

class _SignInVerifyPageState extends State<SignInVerifyPage> {
  var _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  final _formKey2 = GlobalKey<FormState>();
  Future _formSubmit(BuildContext context) async {
    _formKey2.currentState?.save();
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (widget.email!.contains('.com')) {
      if (widget.password != null && widget.email != null) {
        try {
          MyUser? createdUser = await userModel.signUp(
            widget.email!,
            widget.password!,
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UsernameSelectorPage(),
          ));
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => ChangeableAlertDialog(
                  baslik: LocaleKeys.login_signUpAlertDialog.locale,
                  icerik: LocaleKeys.login_thisEmailUsing.locale,
                  anaButonYazisi: LocaleKeys.login_okay.locale));
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (builder) => ChangeableAlertDialog(
              baslik: LocaleKeys.login_signUpAlertDialog.locale,
              icerik: LocaleKeys.login_emailCheckText.locale,
              anaButonYazisi: LocaleKeys.login_okay.locale));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.appBarIcon(),
        body: formBuild(context));
  }

  Form formBuild(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey2,
      child: Padding(
        padding: Constants.logInPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              LocaleKeys.login_createAccountText.locale,
              style: Constants.hesabiniOlusturFont(),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 10, right: MediaQuery.of(context).size.width / 10),
                child: emailTextFormField()),
            Padding(
              padding: EdgeInsets.only(
                  top: 15, right: MediaQuery.of(context).size.width / 10),
              child: passwordTextFormField(),
            ),
            Spacer(
              flex: 4,
            ),
            buildRichText(context),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _formSubmit(context),
              style: Constants.myButtonStyle(),
              child: Text(
                LocaleKeys.login_signUpButtonText2.locale,
                style: TextStyle(
                    fontSize: 22, fontFamily: Constants.boldFont().fontFamily),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      validator: (value) {
        return value!.contains('@')
            ? null
            : LocaleKeys.login_emailCheckText.locale;
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (girilenEmail) {
        widget.email = girilenEmail;
      },
      decoration: Constants.textFormFieldDecoration(
          LocaleKeys.login_phoneAndEmail.locale),
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      validator: (value) {
        return value!.length >= 6
            ? null
            : LocaleKeys.login_passwordAtLeast.locale;
      },
      onSaved: (girilenPassword) {
        widget.password = girilenPassword;
      },
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.solidEyeSlash,
                size: 25),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          labelText: LocaleKeys.login_password.locale,
          labelStyle: Constants.signInTextStyle(),
          border: Constants.myOutlineInputBorder()),
    );
  }

  RichText buildRichText(BuildContext context) {
    return RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
      TextSpan(
          text: LocaleKeys.login_infoText.locale,
          style: Constants.signInPageTextStyle()),
      TextSpan(
          text: LocaleKeys.login_infoRichText1.locale,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogInPage(),
                )),
          style: Constants.signInPageTextStyleBold()),
      TextSpan(
          text: LocaleKeys.login_infoText2.locale,
          style: Constants.signInPageTextStyle()),
      TextSpan(
          text: LocaleKeys.login_infoRichText2.locale,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogInPage(),
                )),
          style: Constants.signInPageTextStyleBold()),
      TextSpan(
          text: LocaleKeys.login_infoText3.locale,
          style: Constants.signInPageTextStyle()),
      TextSpan(
          text: LocaleKeys.login_infoRichText3.locale,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogInPage(),
                )),
          style: Constants.signInPageTextStyleBold()),
      TextSpan(
          text: LocaleKeys.login_infoRichText4.locale,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogInPage(),
                )),
          style: Constants.signInPageTextStyleBold()),
      TextSpan(
          text: LocaleKeys.login_infoText4.locale,
          style: Constants.signInPageTextStyle()),
    ]));
  }
}
