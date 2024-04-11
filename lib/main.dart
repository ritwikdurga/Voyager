// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/login_section/intro_page.dart';
import 'package:voyager/splash/splash.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/main_page.dart';
import 'firebase_options.dart';
import 'map_section/autocomplete_func.dart';
import 'map_section/normal__map_page.dart';
import 'map_section/search_functionality.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:voyager/pages/profile_sections/user_provider.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => MyIndexProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TabIndexProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> getNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seeeeen = (prefs.getBool('seeeeen') ?? false);
    // Determine the next screen based on some condition
    if (!_seeeeen) {
      return Future.value(MainPage(
        isRegistered: false,
      )); // Return the MainPage if condition is true
    } else {
      return Future.value(
          IntroPage()); // Return an alternate page if condition is false
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      title: 'Voyager',
      debugShowCheckedModeBanner: false,
      home: SplashPage(), //main page as the main page
      // will check if the user is logged in or not
      // and return the home page or the login page
    );
  }
}
