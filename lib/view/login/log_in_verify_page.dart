// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/changeable_alert_dialog.dart';

import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/home/home_page.dart';

// ignore: must_be_immutable
class LogInVerifyPage extends StatefulWidget {
  String girilenDeger;

  LogInVerifyPage({
    Key? key,
    required this.girilenDeger,
  }) : super(key: key);

  @override
  State<LogInVerifyPage> createState() => _LogInVerifyPageState();
}

class _LogInVerifyPageState extends State<LogInVerifyPage> {
  var _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  Future _formSubmit(BuildContext context) async {
    _formKey.currentState?.save();
    final userModel = Provider.of<UserModel>(context, listen: false);
    debugPrint('email : ${widget.girilenDeger} , password : $_password');
    await userModel.currentUser();
    MyUser? girisYapanUser =
        await userModel.signInEmailAndPassword(widget.girilenDeger, _password!);
    await userModel.currentUser();
    if (girisYapanUser != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(user: girisYapanUser),
      ));
    } else {
      showDialog(
          context: context,
          builder: (builder) => const ChangeableAlertDialog(
              baslik: 'Giriş Hatası',
              icerik: 'Böyle bir kullanıcı bulunmamaktadır',
              anaButonYazisi: 'Tamam'));
    }
  }

  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.appBarIcon(),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 22),
                child: Text(
                  LocaleKeys.login_enterPassword.locale,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: Constants.boldFont().fontFamily),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  initialValue: widget.girilenDeger,
                  decoration: InputDecoration(
                      enabled: false,
                      labelText: LocaleKeys.login_email.locale,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: Constants.boldFont().fontFamily),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    return value!.length >= 6
                        ? null
                        : LocaleKeys.login_passwordAtLeast.locale;
                  },
                  obscureText: !_passwordVisible,
                  onSaved: (girilenPassword) {
                    _password = girilenPassword;
                  },
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
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: Constants.boldFont().fontFamily),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              const SizedBox(
                height: 275,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(200, 45)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text(
                        LocaleKeys.login_forgotPass.locale,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.boldFont().fontFamily),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () => _formSubmit(context),
                      style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(100, 40)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: Text(
                        LocaleKeys.login_signInButtonRichText.locale,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: Constants.boldFont().fontFamily),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
