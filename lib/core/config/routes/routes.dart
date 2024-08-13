import 'package:flutter/material.dart';
import 'package:msh_app/features/auth/screens/login_screen.dart';
import 'package:msh_app/features/auth/screens/sign_up_screen.dart';
import 'package:msh_app/features/screens/add_schoolership_screen.dart';
import 'package:msh_app/features/screens/admin/orders_screen.dart';
import 'package:msh_app/features/screens/book_ticket_screen.dart';
import 'package:msh_app/features/screens/create_cv_screen.dart';
import 'package:msh_app/features/screens/home_screen.dart';
import 'package:msh_app/features/screens/passport_resrvision_screen.dart';
import 'package:msh_app/features/screens/schooler_ships_details_sccren.dart';
import 'package:msh_app/features/screens/schooler_ships_screen.dart';
import 'package:msh_app/features/screens/translate_doc_screen.dart';
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
    case CreateCvScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const CreateCvScreen()));
    case SchoolerShipsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SchoolerShipsScreen()));
    case AddSchoolerShip.routeName:
      return MaterialPageRoute(builder: ((_) => const AddSchoolerShip()), settings: settings);
    case ScholerShipDetailsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const ScholerShipDetailsScreen()));
    case PassportReversationScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const PassportReversationScreen()));

    case BookTicketScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const BookTicketScreen()));

    case TransalteDocScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const TransalteDocScreen()));


    case OrdersScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const OrdersScreen()));

      



      
  
  }

  return null;
}
