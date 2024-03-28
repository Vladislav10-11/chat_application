import 'package:chat_application/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user stream
/*
List<Map<String,dynamic = 
[
{
  'email' test@gmail.com 
  'id' ...
},
{
  'email' vladcerkasin261@gmail.com 
  'id' ...
}
]


*/
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        // return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user Info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    // construct chat room ID the two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
        .collection("Chat_Rooms")
        .doc(chatRoomID)
        .collection("Message")
        .add(newMessage.toMap());
  }
  // get message

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroomID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("Chat_Rooms")
        .doc(chatRoomID)
        .collection("Message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
