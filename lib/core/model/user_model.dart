import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? userID;
  String? email;
  String? username;
  String? name;
  String? iconAdress;
  DateTime? createdAt;


  MyUser({
    this.name,
    this.username,
    this.iconAdress,
    required this.userID,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'name': name,
      'username': username,
      'iconAdress': iconAdress ?? 'https://i.ibb.co/WHjShMN/default-icon.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        name = map['name'],
        username = map['username'],
        iconAdress = map['iconAdress'],
        createdAt = (map['createdAt'] as Timestamp).toDate();

  @override
  String toString() {
    return 'MyUser{userID=$userID, email=$email, username=$username,  name=$name ,iconAdress=$iconAdress, createdAt=$createdAt}';
  }
}
