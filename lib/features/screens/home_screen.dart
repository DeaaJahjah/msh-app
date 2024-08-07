import 'package:flutter/material.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/features/auth/Services/authentecation_service.dart';
import 'package:msh_app/features/auth/screens/login_screen.dart';
import 'package:msh_app/features/screens/book_ticket_screen.dart';
import 'package:msh_app/features/screens/create_cv_screen.dart';
import 'package:msh_app/features/screens/passport_resrvision_screen.dart';
import 'package:msh_app/features/screens/schooler_ships_screen.dart';
import 'package:msh_app/features/screens/translate_doc_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('home')),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                context.firebaseUser == null
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        },
                        child: Image.asset(
                          'assets/images/login.png',
                          width: 50,
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          await FlutterFireAuthServices().signOut(context);
                        },
                        icon: const Icon(Icons.logout)),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(CreateCvScreen.routeName);
                },
                child: Image.asset('assets/images/cv.png')),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(TransalteDocScreen.routeName);
                },
                child: Image.asset('assets/images/translate.png')),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SchoolerShipsScreen.routeName);
                },
                child: Image.asset('assets/images/schooler ship.png')),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BookTicketScreen.routeName);
                },
                child: Image.asset('assets/images/travlale.png')),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PassportReversationScreen.routeName);
                },
                child: Image.asset('assets/images/passport.png')),
          ],
        ),
      ),
    );
  }
}
