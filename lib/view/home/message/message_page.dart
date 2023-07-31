import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/core/extensions/string_extension.dart';

import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/viewmodel/user_model.dart';
import 'package:twitter/generated/locale_keys.g.dart';
import 'package:twitter/view/home/message/chat.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context, );
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.UsersPage_users.locale),
      ),
      body: FutureBuilder<List<MyUser>>(
          future: _userModel.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var allUsers = snapshot.data;
              if (allUsers!.length - 1 > 0) {
                return ListView.builder(
                  itemCount: allUsers.length,
                  itemBuilder: (context, index) {
                    var currentUser = snapshot.data![index];
                    if (currentUser.userID != _userModel.user!.userID) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                currentUser: _userModel.user!,
                                chattingUser: currentUser),
                          ));
                        },
                        child: myListTile(currentUser),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Center(
                  child: Text('Kayıtlı bir kullanıcı yok'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  myListTile(MyUser currentUser) {
    if(currentUser.username!=null && currentUser.email !=null&& currentUser.iconAdress!=null){
      return ListTile(
      title: Text(currentUser.username!),
      subtitle: Text(currentUser.email!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(currentUser.iconAdress!),
      ),
    );
    }else{
      return ListTile(
         title: Text(''),
      subtitle: Text(''),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(''),
      ),
    );
      
    }
    
  }
}
