import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/routes/routes.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class App extends StatelessWidget {
  // final StreamChatClient client;
  const App({
    super.key,
    // required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale("ar", "AE"),
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: background,
          scaffoldBackgroundColor: background,
          appBarTheme:
              const AppBarTheme(backgroundColor: background, centerTitle: true, titleTextStyle: appBarTextStyle),
          fontFamily: font),
      initialRoute: '/',
    );
  }
}
