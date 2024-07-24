import 'package:flutter/material.dart';
import 'package:msh_app/features/auth/screens/login_screen.dart';
import 'package:msh_app/features/auth/screens/sign_up_screen.dart';
import 'package:msh_app/home_screen.dart';
import 'package:msh_app/splash_screen.dart';

// import 'package:lets_buy/features/chat/messages_screen.dart';
// import 'package:lets_buy/features/help/help_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const LoginScreen()));
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SignUpScreen()));
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const HomeScreen()));
  }

  return null;
}
