// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';

import 'package:twitter/core/model/mesaj.dart';

import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';

class ChatPage extends StatefulWidget {
  final MyUser currentUser;
  final MyUser chattingUser;
  const ChatPage({
    Key? key,
    required this.currentUser,
    required this.chattingUser,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  var _controllerText = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    MyUser _currentUser = widget.currentUser;
    MyUser _chattingUser = widget.chattingUser;
    UserModel _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.ChatPage_appBarText.locale),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<List<Mesaj>>(
              stream: _userModel.getMessages(
                  _currentUser.userID!, _chattingUser.userID!),
              builder: (context, messageList) {
                if (!messageList.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var allMessages = messageList.data;
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: allMessages?.length,
                  itemBuilder: (context, index) {
                    return _chatBaloon(allMessages![index]);
                  },
                );
              },
            )),
            Container(
              padding: EdgeInsets.only(bottom: 8, left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controllerText,
                      cursorColor: Colors.blueGrey,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: LocaleKeys.ChatPage_writeMessage.locale,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: FloatingActionButton(
                      onPressed: () async {
                        if (_controllerText.text.trim().length > 0) {
                          Mesaj _savedMessage = Mesaj(
                            kimden: _currentUser.userID,
                            kime: _chattingUser.userID,
                            bendenMi: true,
                            mesaj: _controllerText.text,
                          );
                          var sonuc =
                              await _userModel.saveMessage(_savedMessage);
                          if (sonuc) {
                            _controllerText.clear();
                            _scrollController.animateTo(0,
                                duration: Duration(milliseconds: 150),
                                curve: Curves.easeOut);
                          }
                        }
                      },
                      elevation: 0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.navigation,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatBaloon(Mesaj currentMessage) {
    Color pushingMessageColor = Colors.blue;
    Color pullingMessageColor = Colors.teal.shade600;
    var hour = '';
    try {
     hour = _showHour(currentMessage.date ?? Timestamp(1, 1));
    } catch (e) {
      print("ERROR DATE $e");
    }
    var isMyMessage = currentMessage.bendenMi;
    if (isMyMessage!) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: pushingMessageColor),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(
                      '${currentMessage.mesaj}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(hour)
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.chattingUser.iconAdress.toString()),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: pullingMessageColor),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text('${currentMessage.mesaj}'),
                  ),
                ),
                Text(hour)
              ],
            )
          ],
        ),
      );
    }
  }

  String _showHour(Timestamp? date) {
    var formatter = DateFormat.Hm();
    var formattedDate = formatter.format(date!.toDate());
    return formattedDate;
  }
}
