import 'package:chatroom/services/userSession.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseAuth _userAuth = FirebaseAuth.instance;

class AuthServices {
  Future<void> signInAnon(
      {required BuildContext context, required String username}) async {
    context.read<UserSession>().setUserName(username);
    await _userAuth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _userAuth.signOut();
  }

  User? get user => _userAuth.currentUser;
}
