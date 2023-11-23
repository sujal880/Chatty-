import 'package:chatty/screens/services/chat_service.dart';
import 'package:chatty/user_profile/user_profile_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  String username;
  String uid;
  String status;
  String img;
   ChatScreen({super.key,required this.uid,required this.username,required this.status,required this.img});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController=TextEditingController();
  final ChatService chatService=ChatService();
  final firebase=FirebaseAuth.instance;

  void SendMessage()async{
    if(msgController.text.isNotEmpty){
      await chatService.sendMessage(widget.uid, msgController.text.toString());
      //Clear The Controllers
      msgController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 33.h,),
          Container(
            height: 55.h,
            width: double.infinity,
            color: Colors.grey.withOpacity(.9),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.w,
                  backgroundImage: NetworkImage(widget.img),
                ),
                title: Text(widget.username,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                subtitle: Text(widget.status,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ),
          Expanded(child: _buildMessageList()),
          //User Input
          _buildMessageInput()
        ],
      ),
    );
  }

  _buildMessageList(){
    return StreamBuilder(stream: chatService.getMessages(widget.uid, firebase.currentUser!.uid), builder: (context,snapshot){
      if(snapshot.hasError){
        return Center(child: Text(snapshot.hasError.toString()),);
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: Text("Loading..."),);
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    });
  }

 Widget _buildMessageItem(DocumentSnapshot documentSnapshot){
    Map<String,dynamic>data=documentSnapshot.data() as Map<String,dynamic>;

    //Align Messages To Right
   var alignment=(data["senderId"])==firebase.currentUser!.uid?Alignment.centerRight:Alignment.centerLeft;
   return Container(
     alignment: alignment,
     child: Column(
       crossAxisAlignment: (data["senderId"]==firebase.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
       children: [
         Text("${data["senderEmail"]}"),
         Text("${data["message"]}")
     ],),
   );
  }


  Widget _buildMessageInput(){
    return Row(children: [
      Expanded(child: UserField.CustomTextField("Enter Message", false, msgController)),
      IconButton(onPressed: SendMessage, icon: Icon(Icons.send,size: 40,))
    ],);
  }
}
