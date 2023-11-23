import 'package:chatty/routes/on_generated_routes.dart';
import 'package:chatty/screens/login/bloc/login_bloc.dart';
import 'package:chatty/screens/signup/bloc/signup_bloc.dart';
import 'package:chatty/splash/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SignUpBloc()),
          BlocProvider(create: (_) => LoginBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chatty',
          initialRoute: "/",
          onGenerateRoute: OnGeneratedRoutes.route,
          routes: {
            "/": (context) {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
