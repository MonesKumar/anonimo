import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _userAuth = FirebaseAuth.instance;

String? AuthName;

class AuthServices {
  Future<void> signInAnon({required String userName}) async {
    await _userAuth.signInAnonymously();
    AuthName = userName;
  }

  Future<void> signOut() async {
    await _userAuth.signOut();
  }

  User? get user => _userAuth.currentUser;
}
