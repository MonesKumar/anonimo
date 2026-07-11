import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'services/userSession.dart';
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
  await dotenv.load(fileName: '.env');
  final String apiKey = dotenv.env['API_KEY'] ?? "No api key";
  final String authDomain = dotenv.env['authDomain'] ?? 'No authDomain';
  final String projectId = dotenv.env['projectId'] ?? 'No projectID';

  final String storageBucket =
      dotenv.env['storageBucket'] ?? 'No StorageBucket';

  final String messagingSenderId =
      dotenv.env['messagingSenderId'] ?? 'No messagingSenderID';

  final String appId = dotenv.env['appId'] ?? 'No appID';

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: apiKey,
      authDomain: authDomain,
      projectId: projectId,
      storageBucket: storageBucket,
      messagingSenderId: messagingSenderId,
      appId: appId,
    ),
  );
  await userAuth.setPersistence(Persistence.SESSION);
  runApp(ChangeNotifierProvider(
    create: (_) => UserSession(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    ),
  ));
}
