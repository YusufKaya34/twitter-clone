import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/view/home/home_page.dart';
import 'package:twitter/view/login/start_page.dart';
import 'package:twitter/view/login/username_selector_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    if (userModel.state == ViewState.idle) {
      if (userModel.user == null) {
        return const StartPage();
      } else if (userModel.user!.name == null ||
          userModel.user!.username == null) {
        return UsernameSelectorPage();
      
      }else {
        return HomePage(user: userModel.user);
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
