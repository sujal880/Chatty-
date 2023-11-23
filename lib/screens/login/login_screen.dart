import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/login/bloc/login_bloc.dart';
import 'package:chatty/screens/login/bloc/login_events.dart';
import 'package:chatty/screens/login/logincontroller.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white.withOpacity(.8),
        body: SafeArea(
          child: Center(
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
                    "Welcome back you've been missed!",
                    style: TextStyle(
                        fontSize: 16.sp, color: Colors.black.withOpacity(.7)),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  UiHelper.CustomTextField("Email", false, (value) {
                    context.read<LoginBloc>().add(EmailEvents(email: value));
                  }),
                  SizedBox(
                    height: 20.h,
                  ),
                  UiHelper.CustomTextField("Password", true, (value) {
                    context
                        .read<LoginBloc>()
                        .add(PasswordEvents(password: value));
                  }),
                  SizedBox(height: 20.h),
                  UiHelper.CustomButton(() {
                    LoginController(context: context).login();
                  }, "Sign In"),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a Member?",
                        style: TextStyle(
                            fontSize: 18, color: Colors.black.withOpacity(.7)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                PageConst.signuppage, (route) => false);
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
