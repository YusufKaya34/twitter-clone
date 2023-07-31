import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';

import 'package:twitter/core/model/tweet.dart';
import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/constants/buttons.dart';
import 'package:twitter/view/constants/constants.dart';

class Post extends StatefulWidget {
  final MyUser currentUser;
  const Post({super.key, required this.currentUser});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController myController = TextEditingController();
  @override
  void setState(VoidCallback fn) {
    UserModel _userModel = Provider.of<UserModel>(
      context,
    );
    _userModel.currentUser();
    _userModel.getAllUser();

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(
      context,
    );
    MyUser _currentUser = widget.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white24,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (myController.text.trim().length > 0) {
                    await _userModel.currentUser();
                    await _userModel.getAllUser();

                    Tweet _savedTweet = Tweet(
                      userID: _currentUser.userID!,
                      text: myController.text,
                      
                    );

                    var sonuc = await _userModel.saveTweet(_savedTweet);
                    if (sonuc) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                style: Buttons.postAppBarButtonStyle(),
                child: Text(
                  LocaleKeys.Tweet_tweetButtonText.locale,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: Constants.boldFont().fontFamily),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: null,
          constraints:
              const BoxConstraints(maxHeight: 999999999999999, minHeight: 500),
          child: TextField(
            style: const TextStyle(fontSize: 24),
            controller: myController,
            maxLines: 6,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: LocaleKeys.Tweet_tweetText.locale),
          ),
        ),
      ),
    );
  }
}
