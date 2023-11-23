import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/signup/bloc/signup_bloc.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpController{
  final BuildContext context;
  SignUpController({required this.context});
  final firebase=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  signUp()async{
    final state=context.read<SignUpBloc>().state;
    String email=state.email;
    String password=state.password;
    String confirmpassword=state.confirmpassword;
    if(email=="" && password=="" && confirmpassword==""){
      return UiHelper.CustomSnackBar("Enter Required Fields", context);
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await firebase.createUserWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.pushNamedAndRemoveUntil(context, PageConst.userProfile, (route) => false);
        });
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomSnackBar(ex.code.toString(), context);
      }
    }
  }
}