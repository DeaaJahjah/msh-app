import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/core/config/routes/routes.dart';
import 'package:msh_app/features/providers/sata_provider.dart';
import 'package:msh_app/features/providers/translate_docs_provider.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateProvider>(create: (_) => StateProvider()),
        ChangeNotifierProvider<TranslateDocsProvider>(create: (_) => TranslateDocsProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
