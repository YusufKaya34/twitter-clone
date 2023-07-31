// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/generated/locale_keys.g.dart';

import 'package:twitter/view/constants/buttons.dart';
import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/login/log_in_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: Constants.appBarIcon(),
      body: Padding(
        padding: Constants.logInPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              LocaleKeys.login_startText.locale,
              style: Constants.boldFont(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 16),
            Buttons.startPageButton(context),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [richTextBuild(context)],
              ),
            )
          ],
        ),
      ),
    );
  }

  RichText richTextBuild(BuildContext context) {
    return RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
      TextSpan(
          text: LocaleKeys.login_signInButtonText.locale,
          style: Constants.forgotPasswordTextStyle()),
      TextSpan(
          text: LocaleKeys.login_signInButtonRichText.locale,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LogInPage(), fullscreenDialog: true)),
          style: Constants.startPageTextStyle()),
    ]));
  }
}
