import 'package:flutter/material.dart';
import 'package:msh_app/core/config/widgets/elevated_button_custom.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Image.asset('assets/images/thanks.png'),
          const SizedBox(height: 30),
          ElevatedButtonCustom(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'موافق')
        ],
      )),
    );
  }
}
