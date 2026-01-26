import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class StoreService {
  Stream<QuerySnapshot> messagesStream() {
    final Stream<QuerySnapshot> messages = db
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots();
    return messages;
  }

  Future<void> sendMessage(
      {required String content, required userName, required userID}) async {
    final createdAt = DateTime.now();
    final expiresAt =
        Timestamp.fromDate(createdAt.add(const Duration(hours: 1)));
    if (content.trim().isEmpty) {
      return;
    }
    await db.collection("messages").add({
      "userID": userID,
      "content": content,
      "userName": userName.toString(),
      "createdAt": createdAt,
      "expiresAt": expiresAt
    });
  }
}
