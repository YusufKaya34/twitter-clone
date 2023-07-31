import 'package:flutter/material.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/generated/locale_keys.g.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(LocaleKeys.NotificationPage_Notification.locale),
    );
  }
}
