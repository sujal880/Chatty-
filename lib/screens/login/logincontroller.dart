import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/login/bloc/login_bloc.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginController {
  final BuildContext context;
  LoginController({required this.context});
  login() async {
    final state = context.read<LoginBloc>().state;
    final firebase = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    String email = state.email;
    String password = state.password;

    if (email == "" && password == "") {
      return UiHelper.CustomSnackBar("Enter Required Fields", context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await firebase
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, PageConst.homescreen, (route) => false);
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(ex.code.toString(), context);
      }
    }
  }
}
