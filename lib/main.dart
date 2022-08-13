import 'package:assignment_4/pages/calculator_page.dart';
import 'package:assignment_4/pages/home_page.dart';
import 'package:assignment_4/pages/login_page.dart';
import 'package:assignment_4/pages/news_page.dart';
import 'package:assignment_4/pages/register_page.dart';
import 'package:assignment_4/pages/weather_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/weather': (context) => const WeatherPage(),
        '/news': (context) => const NewsPage(),
        '/calculator': (context) => const CalculatorPage(),
      },
    );
  }
}

