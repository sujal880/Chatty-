import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/signup/bloc/signup_bloc.dart';
import 'package:chatty/screens/signup/bloc/signup_events.dart';
import 'package:chatty/screens/signup/bloc/signup_states.dart';
import 'package:chatty/screens/signup/signup_controller.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<SignUpBloc,SignUpStates>(
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white.withOpacity(.8),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      size: 100.h,
                      color: Colors.black.withOpacity(.5),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Let's Create an account for you!",
                      style: TextStyle(
                          fontSize: 16.sp, color: Colors.black.withOpacity(.7)),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    UiHelper.CustomTextField("Email", false, (value) {
                      context.read<SignUpBloc>().add(EmailEvents(email: value));
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    UiHelper.CustomTextField("Password", true, (value) {
                      context.read<SignUpBloc>().add(PasswordEvents(password: value));
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    UiHelper.CustomTextField(
                        "Confirm Password", true, (value) {
                          context.read<SignUpBloc>().add(ConfirmPasswordEvents(confirmpassword: value));
                    }),
                    SizedBox(height: 20.h),
                    UiHelper.CustomButton(() {
                      SignUpController(context: context).signUp();
                    }, "Sign Up"),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a Member?",style: TextStyle(fontSize: 18,color: Colors.black.withOpacity(.7)),),
                        TextButton(onPressed: (){
                          Navigator.pushNamedAndRemoveUntil(context, PageConst.loginpage, (route) => false);
                        }, child: Text("Login now",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
