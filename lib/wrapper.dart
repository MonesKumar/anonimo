import 'package:chatroom/pages/chatpage.dart';
import 'package:chatroom/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/userpage.dart';

FirebaseAuth _userAuth = FirebaseAuth.instance;
AuthServices authservice = AuthServices();

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data == null) {
            return UserPage();
          } else {
            return ChatPage();
          }
        });
  }
}
