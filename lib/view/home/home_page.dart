// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';

import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/home/flow_page.dart';
import 'package:twitter/view/home/message/message_page.dart';
import 'package:twitter/view/home/notification_page.dart';
import 'package:twitter/view/home/post_screen.dart';
import 'package:twitter/view/home/search_page.dart';
import 'package:twitter/view/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  final MyUser? user;
  const HomePage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int secilenMenuItem = 0;
  List<Widget> tumSayfalar = [];
  FlowPage? pageFlow;
  SearchPage? pageSearch;
  NotificationPage? pageNotification;
  MessagePage? pageMessage;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    UserModel _userModel = Provider.of<UserModel>(
      context,
    );
    pageSearch = const SearchPage();
    pageFlow = FlowPage(
      currentUser: _userModel.user!,
    );
    pageNotification = const NotificationPage();
    pageMessage = const MessagePage();
    tumSayfalar = [
      pageFlow!,
      pageSearch!,
      pageNotification!,
      pageMessage!,
    ];
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(
      context,
    );
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('${LocaleKeys.homePage_welcomeUser.locale} ${_userModel.user?.name}'),
              ),
              ListTile(
                title:  Text(LocaleKeys.homePage_profile.locale),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const ProfilePage(),
                  ));
                },
              ),
              ListTile(
                title:  Text(LocaleKeys.homePage_ThemeSettings.locale),
                onTap: () {},
              ),
              ListTile(
                title: Text('${LocaleKeys.homePage_welcomeUser.locale} ${_userModel.user?.userID}'),
                onTap: () {},
              ),
              ListTile(
                title:  Text(LocaleKeys.homePage_logOut.locale),
                onTap: () {
                  _cikisYap(context);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => Post(
              currentUser: _userModel.user!,
            ),
          )),
          child: const Icon(Icons.add, size: 28),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: 24,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.notifications_none_rounded,
                    color: Colors.black, size: 24),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.mail_outline_outlined,
                    color: Colors.black, size: 24),
              ),
            ],
            backgroundColor: Colors.white,
            currentIndex: secilenMenuItem,
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              setState(() {
                secilenMenuItem = index;
              });
              
            }),
        body: tumSayfalar[secilenMenuItem]);
  }

  bottomNavigationBar() {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 24,
                color: Colors.black,
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 24,
                color: Colors.black,
              ),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded,
                  color: Colors.black, size: 24),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 24,
                color: Colors.black,
              ),
              backgroundColor: Colors.black),
        ],
        backgroundColor: Colors.white,
        currentIndex: secilenMenuItem,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            secilenMenuItem = index;
          });
        });
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final userModel = Provider.of<UserModel>(context, listen: false);

    bool sonuc = await userModel.signOut();
    print('çıkış yapıldı');
    return sonuc;
  }
}

