import 'package:chatroom/pages/chatpage.dart';
import 'package:chatroom/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//varibles
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth userAuth = FirebaseAuth.instance;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDpWUqEAGuJfVKFgCnXLvPCLym4XxcyMVo",
      authDomain: "web-based-chatapp.firebaseapp.com",
      projectId: "web-based-chatapp",
      storageBucket: "web-based-chatapp.firebasestorage.app",
      messagingSenderId: "320957310758",
      appId: "1:320957310758:web:0cfc9962768ae9ac5683e7",
    ),
  );
  await userAuth.setPersistence(Persistence.SESSION);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatPage(),
  ));
}
