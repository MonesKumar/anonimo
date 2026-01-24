import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _userAuth = FirebaseAuth.instance;

class AuthServices {
  Future<void> signInAnon() async {
    await _userAuth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _userAuth.signOut();
  }

  User? get user => _userAuth.currentUser;
}
