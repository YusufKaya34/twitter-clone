import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalApi {
  
  static Future setupOneSignal() async {
    Future<String?> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
         var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; 
      } else if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.androidId; 
      }
    }
    String? deviceID = await _getId();
      print(deviceID);

    
    final String deviceLang = PlatformDispatcher.instance.locale.languageCode;

    OneSignal oneSignal = OneSignal.shared;
    oneSignal.promptUserForPushNotificationPermission();
    oneSignal.setAppId("00ca2071-9d0c-4d9e-b2e7-1c3592c06d0f");
      oneSignal.setExternalUserId(deviceID!);
    oneSignal.setLanguage(deviceLang);
    oneSignal.sendTags({
        "deviceID": deviceID,
      "deviceLang": deviceLang,
    });
    oneSignal.setNotificationOpenedHandler((openedResult) {
      String? data = openedResult.notification.additionalData as String?;
      if (data != null) {}
    });
  }
}
