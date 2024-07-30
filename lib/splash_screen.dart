import 'dart:async';

import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/screens/home_screen.dart';
import 'package:show_up_animation/show_up_animation.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // if (context.firebaseUser != null) {
      // } else {
      //   Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      // }
    });
    return Scaffold(
      backgroundColor: background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowUpAnimation(
              delayStart: const Duration(milliseconds: 50),
              animationDuration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
              direction: Direction.vertical,
              offset: 0.5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.sizeOf(context).height * 0.70,
                  ),
                  // Image.asset(
                  //   'assets/images/logo-with-text.png',
                  //   height: MediaQuery.sizeOf(context).height * 0.25,
                  // ),
                  // sizedBoxSmall,

                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(color: blue),
                ],
              )),
        ],
      )),
    );
  }
}
