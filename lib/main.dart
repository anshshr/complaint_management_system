import 'package:complaint_management_system/components/app/splash_screen.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:complaint_management_system/firebase_options.dart';
import 'package:complaint_management_system/provider/language_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  Gemini.init(apiKey: 'AIzaSyDi4t3C0UUeZArtyQiAO6alqKgwYc5JHio');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? languageCode = pref.getString('language') ?? 'en';
  print(pref.getBool('login'));

  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(Locale(languageCode)),
      child: MyApp(isLoggedIn: pref.getBool('login') ?? false),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rail Madad',
      locale: Provider.of<LanguageProvider>(context).locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: isLoggedIn
          ? HomePage(
              username: 'User',
              changeLanguage: (String languageCode) {},
            )
          : const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
