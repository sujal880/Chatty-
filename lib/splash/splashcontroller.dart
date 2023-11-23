import 'package:chatty/screens/homescreen.dart';
import 'package:chatty/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashController extends StatefulWidget {
  const SplashController({super.key});

  @override
  State<SplashController> createState() => _SplashController();
}

class _SplashController extends State<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
        if(snapshot.hasData){
          return HomeScreen();
        }
        else{
          return LoginScreen();
        }
      }),
    );
  }
}
