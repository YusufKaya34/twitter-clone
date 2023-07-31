import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/view/model/tw_model.dart';
import 'package:twitter/view/profile/profile_page.dart';

class FlowPage extends StatefulWidget {
  final MyUser currentUser;

  const FlowPage({super.key, required this.currentUser});

  @override
  State<FlowPage> createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {
  @override
  void setState(VoidCallback fn) {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    _userModel.currentUser();

    _userModel.getAllUser();
    widget.currentUser;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    MyUser _currentUser = widget.currentUser;

    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    _userModel.user;

    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    _userModel.user;
                    _userModel.currentUser();
                    _userModel.getAllUser();
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
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
          )),
      body: Center(
          child: Column(children: [
        Expanded(
            child: FutureBuilder<List<Tweet>>(
          future: _userModel.getTweets(
            _currentUser.userID!,
          ),
          builder: (context, tweetList) {
            if (!tweetList.hasData) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            var allTweets = tweetList.data;
            return ListView.builder(
              // reverse: true,buraya tweetlerdeki pp name ve usernameyi userID ile çekmelisin
              itemCount: allTweets?.length,
              itemBuilder: (context, index) {
                return _tweets(allTweets![index]);
              },
            );
          },
        )),
      ])),
    );
  }

  Widget _tweets(Tweet tweet) {
    return TweetModel(
      name: tweet.user?.name,
      username: tweet.user?.username,
      tweetText: tweet.text,
      iconAdress: tweet.user?.iconAdress ??
          "https://static.vecteezy.com/system/resources/previews/009/734/564/original/default-avatar-profile-icon-of-social-media-user-vector.jpg",
    );
  }
}
