import 'package:flutter/material.dart';
import 'package:chatroom/services/auth_service.dart';
import 'package:flutter_svg/svg.dart';

AuthServices authservice = AuthServices();

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Container(
                  color: Colors.blue,
                  height: double.infinity,
                  child: SvgPicture.asset(
                    "assets/images/CHATTING.svg",
                    fit: BoxFit.cover,
                  ))),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hey There Stranger!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.bold,
                          fontSize: 48),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Chat anonymously with strangers\nPick an username to start !",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: userName,
                        decoration: const InputDecoration(
                          label: Text("user-name"),
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelStyle: TextStyle(color: Colors.blue),
                          suffixIcon: Icon(Icons.alternate_email),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () =>
                            authservice.signInAnon(userName: userName.text),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 10),
                          child: Text("Start Chatting !",
                              style: TextStyle(fontSize: 21)),
                        ))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
