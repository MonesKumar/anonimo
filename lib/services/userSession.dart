import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSession extends ChangeNotifier {
  String? userName;
  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void signOutUser() {
    userName = null;
    notifyListeners();
  }
}
