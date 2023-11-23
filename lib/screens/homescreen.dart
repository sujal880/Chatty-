import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/services/chat_screen.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "Chatty",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.withOpacity(.9),
          actions: [
            IconButton(onPressed: ()async{
              try{
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushNamedAndRemoveUntil(context, PageConst.loginpage, (route) => false);
                });
              }
              catch(ex){
                return UiHelper.CustomSnackBar(ex.toString(), context);
              }
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where("Email",
                    isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snasphot) {
              if (snasphot.connectionState == ConnectionState.active) {
                if (snasphot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Card(
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          uid: snasphot.data!.docs[index]
                                              ["uid"],
                                          username: snasphot.data!.docs[index]
                                              ["Name"],
                                          status: snasphot.data!.docs[index]
                                              ["Status"],
                                          img: snasphot.data!.docs[index]
                                              ["Images"])));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${snasphot.data!.docs[index]["Images"]}"),
                                radius: 30,
                              ),
                              title:
                                  Text("${snasphot.data!.docs[index]["Name"]}"),
                              subtitle: Text(
                                  "${snasphot.data!.docs[index]["Status"]}"),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snasphot.data!.docs.length,
                  );
                } else if (snasphot.hasError) {
                  return Center(
                    child: Text("${snasphot.hasError.toString()}"),
                  );
                } else {
                  return Center(
                    child: Text("Data Not Found!!"),
                  );
                }
              } else {
                return Center(child: Text("Loading..."));
              }
            }),
      ),
    );
  }
}
