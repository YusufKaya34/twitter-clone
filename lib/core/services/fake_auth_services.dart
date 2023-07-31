import 'package:twitter/core/model/user_model.dart';
import 'package:twitter/core/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "123123123123123213123123123";

  @override
  Future<MyUser> currentUser() async {
    return await Future.value(
        MyUser(userID: userID, email: "fakeuser@fake.com"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<MyUser> singInAnonymously() async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => MyUser(
              userID: userID,
              email: "fakeuser@fake.com",
            ));
  }

 /* @override
  Future<MyUser?> singInWithGoogle() async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => MyUser(
              userID: 'Google_user_id_123456',
              email: "fakeuser@fake.com",
            ));
  }*/

  @override
  Future<MyUser?> signInEmailAndPassword(String email, String password) async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => MyUser(
              userID: 'Sign_In_user_id_123456',
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<MyUser?> signUp(String email, String password) async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => MyUser(
              userID: 'Created_user_id_123456',
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    return true;
  }
}
