import 'package:assignment_4/pages/calculator_page.dart';
import 'package:assignment_4/pages/home_page.dart';
import 'package:assignment_4/pages/login_page.dart';
import 'package:assignment_4/pages/news_page.dart';
import 'package:assignment_4/pages/register_page.dart';
import 'package:assignment_4/pages/weather_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This is the main function which runs when the flutter app is launched
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb?const FirebaseOptions(
        apiKey: "AIzaSyC_MqKLC2ExkeL8lnKvJQATlrGuWAIxsfI",
        authDomain: "assignment4-347b6.firebaseapp.com",
        projectId: "assignment4-347b6",
        storageBucket: "assignment4-347b6.appspot.com",
        messagingSenderId: "341975139179",
        appId: "1:341975139179:web:acadb7023fd30d971a022e",
        measurementId: "G-11NZ1FXXEZ"
    ): null,
  ); //Initialize firebase
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
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/', // The initial route the app will be redirected to.
      routes: { // All the routes of the app is listed below.
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/weather': (context) => const WeatherPage(),
        '/news': (context) => const NewsPage(),
        '/calculator': (context) => const CalculatorPage(),
      },
    );
  }
}

