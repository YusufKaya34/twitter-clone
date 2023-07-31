// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/int_extension.dart';
import 'package:twitter/core/extensions/string_extension.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';

import 'package:twitter/view/constants/constants.dart';

class TweetModel extends StatefulWidget {
  final String iconAdress;
  final String? name;
  final String? username;

  final String? tweetText;

  final int like;
  final int reTweet;
  final int comment;
  const TweetModel({
    Key? key,
    required this.iconAdress,
    required this.name,
    required this.username,
    required this.tweetText,
    this.like = 0,
    this.reTweet = 0,
    this.comment = 0,
  }) : super(key: key);

  @override
  State<TweetModel> createState() => _TweetModelState();
}

class _TweetModelState extends State<TweetModel> {
  @override
  void setState(VoidCallback fn) {
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.user;
    userModel.currentUser();
    userModel.getAllUser();

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, left: 15),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                  image: NetworkImage(widget.iconAdress), fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 137,
                    child: Text(
                      widget.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      widget.username.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Text(' - 3 ${LocaleKeys.login_day.locale}',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                widget.tweetText!,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        widget.comment.toPercentCount(),
                        style: Constants.tweetModelTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.repeat,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        widget.reTweet.toPercentCount(),
                        style: Constants.tweetModelTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        widget.like.toPercentCount(),
                        style: Constants.tweetModelTextStyle(),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.share_outlined,
                        color: Colors.grey.shade600, size: 20),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
