import 'package:chatty/models/messagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  //Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    //Get Current User Info
    final String currentUserId = firebase.currentUser!.uid;
    final String currentUserEmail = firebase.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //Create a New Message
    MessageModel newMessage = MessageModel(
        timestamp: timestamp,
        receiverId: receiverId,
        message: message,
        senderId: currentUserId,
        senderEmail: currentUserEmail);
    //Construct ChatRoom with Unique Id
    List<String>id=[currentUserId,receiverId];
    id.sort();
    String chatroomId=id.join("_");
    await firestore.collection("chat_rooms").doc(chatroomId).collection("messages").add(newMessage.toMap());
  }

  Stream<QuerySnapshot>getMessages(String userId,String otherUserID){
    List<String>ids=[userId,otherUserID];
    ids.sort();
    String chatroomId=ids.join("_");
    return firestore.collection("chat_rooms").doc(chatroomId).collection("messages").orderBy("timestamp",descending: false).snapshots();
  }
}
