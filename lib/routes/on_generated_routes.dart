import 'package:chatty/screens/services/chat_screen.dart';
import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/homescreen.dart';
import 'package:chatty/screens/login/login_screen.dart';
import 'package:chatty/screens/signup/signup_screen.dart';
import 'package:chatty/splash/splashcontroller.dart';
import 'package:chatty/splash/splashscreen.dart';
import 'package:chatty/user_profile/userprofile.dart';
import 'package:flutter/material.dart';

class OnGeneratedRoutes {
  static Route<dynamic> route(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case PageConst.loginpage:
        {
          return materialBuilder(widget: const LoginScreen());
        }
      case PageConst.signuppage:
        {
          return materialBuilder(widget: const SignUpScreen());
        }
      case PageConst.homescreen:
        {
          return materialBuilder(widget: const HomeScreen());
        }
      case PageConst.splashscreen:
        {
          return materialBuilder(widget: const SplashScreen());
        }
      case PageConst.splashcontroller:{
        return materialBuilder(widget: const SplashController());
      }
      case PageConst.userProfile:{
        return materialBuilder(widget: const UserProfileScreen());
      }

      default:
        {
          return materialBuilder(widget: const ErrorPage());
        }
    }
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Oops an Error Occured!!"),
      ),
    );
  }
}
