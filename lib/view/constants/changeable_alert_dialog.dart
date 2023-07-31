import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/constants/changeable_platform.dart';

class ChangeableAlertDialog extends ChangeablePlatform {
  final String baslik;
  final String icerik;
  final String anaButonYazisi;
  final String? iptalButonYazisi;

  const ChangeableAlertDialog(
      {super.key, required this.baslik,
      required this.icerik,
      required this.anaButonYazisi,
      this.iptalButonYazisi});
  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(baslik),
      content: Text(icerik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(baslik),
      content: Text(icerik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  List<Widget> _dialogButonlariniAyarla(BuildContext context) {
    final tumButonlar = <Widget>[];
    if (Platform.isIOS) {
      if (iptalButonYazisi != null) {
        tumButonlar.add(CupertinoDialogAction(
          child: Text(iptalButonYazisi!),
          onPressed: () {},
        ));
      }

      tumButonlar.add(CupertinoDialogAction(
        child: Text(anaButonYazisi),
        onPressed: () {
           Navigator.pop(context);
        },
      ));
    } else {
      if (iptalButonYazisi != null) {
        tumButonlar.add(ElevatedButton(
          child: Text(iptalButonYazisi!),
          onPressed: () {},
        ));
      }
      tumButonlar.add(ElevatedButton(
          style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(Colors.blue),
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
          child:  Text(anaButonYazisi)));
    }
    return tumButonlar;
  }
}
