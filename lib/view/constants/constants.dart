import 'package:flutter/material.dart';


class Constants {
  static EdgeInsets logInPadding(context) {
    return EdgeInsets.only(left: MediaQuery.of(context).size.width / 9);
  }

  static EdgeInsets usernamePadding(context) {
    return EdgeInsets.only(left: MediaQuery.of(context).size.width / 15);
  }

  static EdgeInsets logInPagePadding(context) {
    return EdgeInsets.only(left: MediaQuery.of(context).size.width / 25);
  }

  static TextStyle forgotPasswordTextStyle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade700,
        fontFamily: Constants.boldFont().fontFamily);
  }

  static TextStyle logInTextStyle() {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: Constants.boldFont().fontFamily);
  }

  static TextStyle startPageTextStyle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.blue,
        fontFamily: Constants.boldFont().fontFamily);
  }

  static TextStyle forgotPasswordHeadlineTextStyle() {
    return TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontFamily: Constants.boldFont().fontFamily);
  }

  static AppBar appBarIcon() {
    return AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white24,
        centerTitle: true,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.all(4),
          width: 35,
          child: Image.asset('assets/icons/twitter_icon.png'),
        ));
  }

  static TextStyle boldFont() {
    return const TextStyle(
        fontSize: 37, fontWeight: FontWeight.w700, fontFamily: 'Cantarell.ttf');
  }

  static TextStyle hesabiniOlusturFont() {
    return const TextStyle(
        fontSize: 30, fontWeight: FontWeight.w700, fontFamily: 'Cantarell.ttf');
  }

  static TextStyle signInTextStyle() {
    return const TextStyle(fontSize: 20, fontFamily: 'Cantarell.ttf');
  }

  static TextStyle signInPageTextStyle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade700,
        fontFamily: 'Cantarell.ttf');
  }

  static TextStyle signInPageTextStyleBold() {
    return const TextStyle(
        decoration: TextDecoration.none,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.blue,
        fontFamily: 'Cantarell.ttf');
  }

  static TextFormField signInPageTextFormField(String labelText) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Constants.signInTextStyle(),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue))),
    );
  }

  static InputDecoration textFormFieldDecoration(
    String labelText,
  ) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: Constants.signInTextStyle(),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)));
  }

  static TextFormField signInPage2TextFormField(String labelText) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 20, fontFamily: Constants.boldFont().fontFamily),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue))),
    );
  }

  static TextStyle tweetModelTextStyle() {
    return TextStyle(
      fontFamily: 'Cantarell.ttf',
      color: Colors.grey.shade700,
      fontSize: 15,
    );
  }

  static OutlineInputBorder myOutlineInputBorder() {
    return const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue));
  }

  static ButtonStyle myButtonStyle() {
    return ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(330, 69)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue));
  }

  static AppBar homePageAppBar() {
    return AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.account_circle_outlined),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white24,
        centerTitle: true,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.all(4),
          width: 35,
          child: Image.asset('assets/icons/twitter_icon.png'),
        ));
  }

  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const LANG_PATH = "assets/lang";
}
