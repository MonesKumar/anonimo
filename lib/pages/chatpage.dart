import 'dart:html';
import 'package:chatroom/services/userSession.dart';
import 'package:provider/provider.dart';
import 'package:chatroom/services/auth_service.dart';
import 'package:chatroom/services/store_service.dart';
import 'package:flutter/material.dart';

final _authservice = AuthServices();
final _storeservice = StoreService();
ScrollController _scrollController = ScrollController();
FocusNode _focus = FocusNode();

List<Map<String, String>> messages = [];

StoreService _storeService = StoreService();

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController? MessageController = TextEditingController();

  Future<void> sendMessage() async {
    await _storeService.sendMessage(
        content: MessageController!.text,
        userName: context.read<UserSession>().userName,
        userID: _authservice.getUserID());
    MessageController!.clear();
  }

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
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: _authservice.signOut,
        ),
      ),
      body: Column(
        children: [
          //message area
          Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.grey.shade300,
                  child: StreamBuilder(
                    stream: _storeService.messagesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "No messages right now !\nStart chatting",
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      final messages = snapshot.data!.docs;
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //Widget is rendered
                        if (_scrollController.hasClients) {
                          //ensures scrollController is connected to a scorllabel widget
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        }
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) =>
                            ChatCard(msg: messages[index]),
                      );
                    },
                  ))),
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
                        focusNode: _focus,
                        onSubmitted: (_) {
                          sendMessage();
                        },
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
                          onPressed: sendMessage, icon: const Icon(Icons.send)),
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
  final msg;
  const ChatCard({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final current_username = context.read<UserSession>().userName;
    final username = msg["userName"];
    final current_userID = _authservice.getUserID();
    final userID = msg["userID"];
    bool isUser = (userID == current_userID) ? false : true;
    final content = msg["content"];
    final sentTime = msg["createdAt"];

    return Align(
      alignment: (!isUser) ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            (!isUser) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          //time
          Text(
            "$username",
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          //message
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              "$content",
              style: const TextStyle(fontSize: 21),
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
