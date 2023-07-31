import 'package:flutter/material.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/login/sign_in_verify_page.dart';

class Buttons {
  static ButtonStyle postAppBarButtonStyle() {
    return ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(100, 0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue));
  }

  static ButtonStyle forgotPasswordButtonStyle() {
    return ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(70, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black));
  }

  static ButtonStyle logInButtonStyle() {
    return ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(70, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black));
  }

  static ButtonStyle logInButtonStyle2() {
    return ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(200, 45)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        elevation: MaterialStateProperty.all(0));
  }

  static ElevatedButton startPageButton(context) {
    return ElevatedButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignInVerifyPage(),
            )),
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size(310, 44)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        child: Text(
          LocaleKeys.login_signUpButtonText.locale,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: Constants.boldFont().fontFamily),
        ));
  }

  static ElevatedButton profilePageButton(context, Function() onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size(320, 42)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        child: Text(
          LocaleKeys.homePage_profileSubmit.locale,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: Constants.boldFont().fontFamily),
        ));
  }

  static ElevatedButton ileriButton(context, Widget page) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page,
      )),
      style: ButtonStyle(
          fixedSize: const MaterialStatePropertyAll(Size(65, 42)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
      child: Text(
        'İleri',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: Constants.boldFont().fontFamily),
      ),
    );
  }

  static ElevatedButton ileriButton2(context, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          fixedSize: const MaterialStatePropertyAll(Size(70, 42)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
      child: Text(
        LocaleKeys.login_nextButtonText.locale,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: Constants.boldFont().fontFamily),
      ),
    );
  }
}
