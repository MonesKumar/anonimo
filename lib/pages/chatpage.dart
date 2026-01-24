import 'dart:html';
import 'package:chatroom/services/userSession.dart';
import 'package:provider/provider.dart';
import 'package:chatroom/services/auth_service.dart';
import 'package:chatroom/services/store_service.dart';
import 'package:flutter/material.dart';

final _authservice = AuthServices();
final _storeservice = StoreService();

List<Map<String, String>> messages = [];

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  TextEditingController? MessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      //gotta update the appbar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 72, color: Colors.white54),
        title: const Text(
          "anonimo",
        ),
      ),
      body: Column(
        children: [
          //message area
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.grey.shade300,
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    msg: messages[index],
                  );
                }),
          )),
          Theme(
            data: Theme.of(context).copyWith(useMaterial3: false),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 9,
                      color: Colors.white.withOpacity(0.9),
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: TextField(
                        controller: MessageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "type a message!",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Material(
                    elevation: 9,
                    color: Colors.white.withOpacity(0.9),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                          onPressed: () => _storeservice.sendMessage(
                              content: MessageController!.text,
                              userName: context.read<UserSession>().userName),
                          icon: const Icon(Icons.send)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Map msg;
  ChatCard({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final createdAt = msg["createdTime"];
    final username = msg["user"];
    final isUser = (username == "me") ? true : false;
    final content = msg["message"];
    return Align(
      alignment: (!isUser) ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            (!isUser) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          //time
          Text(
            "$username",
            style: TextStyle(fontSize: 12),
          ),
          //message
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              "$content",
              style: TextStyle(fontSize: 21),
            ),
          )
        ],
      ),
    );
  }
}
