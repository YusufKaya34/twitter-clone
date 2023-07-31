import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/services/locator.dart';
import 'package:twitter/core/services/one_signal_api.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/view/constants/constants.dart';
import 'package:twitter/view/home/landing_page.dart';
import 'package:twitter/firebase_options.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  OneSignalApi.setupOneSignal();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(EasyLocalization(
      fallbackLocale: const Locale('tr', 'TR'),
      supportedLocales: const [Constants.TR_LOCALE,],
      path: Constants.LANG_PATH,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'CopyOfTwitter',
            theme: ThemeData(
                textTheme: Theme.of(context).textTheme.copyWith(
                    bodyMedium: const TextStyle(
                        fontFamily: 'assets/fonts/Cantarell.ttf'))),
            home: const LandingPage()));
  }
}
