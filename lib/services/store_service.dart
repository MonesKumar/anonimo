import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class StoreService {
  Stream<QuerySnapshot> messagesStream() {
    final Stream<QuerySnapshot> messages =
        db.collection("messages").snapshots();
    return messages;
  }

  Future<void> sendMessage({required String content, required userName}) async {
    final createdAt = DateTime.now();
    final expiresAt =
        Timestamp.fromDate(createdAt.add(const Duration(hours: 1)));
    if (content.trim().isEmpty) {
      return;
    }
    await db.collection("messages").add({
      "content": content,
      "userName": userName,
      "createdAt": createdAt,
      "expiresAt": expiresAt
    });
  }
}
