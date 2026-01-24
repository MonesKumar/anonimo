import 'package:flutter/material.dart';

//Create Sample messages
List<Map<String, String>> messages = [
  {
    "mesasge": "hello world",
    "createdTime": "19:07",
    "user": "Alice",
  },
  {
    "mesasge": "hello alice",
    "createdTime": "19:07",
    "user": "me",
  },
  {
    "mesasge": "hello mon",
    "createdTime": "19:07",
    "user": "Jack",
  },
];

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      //gotta update the appbar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 72, color: Colors.white54),
        title: const Text(
          "anonimo",
        ),
      ),
      body: Column(
        children: [
          //message area
          Expanded(
              child: Container(
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
                      surfaceTintColor: Colors.transparent, // 🔥 FIX
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: const TextField(
                        decoration: InputDecoration(
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
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:
                          IconButton(onPressed: () {}, icon: Icon(Icons.send)),
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
    return Column(
      children: [Text("${msg["mesasge"]}")],
    );
  }
}
