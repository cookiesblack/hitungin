import 'package:hitungin/login.dart';
import 'package:hitungin/myapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Hitungin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define the default text style for the entire app
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),

        // Add more styles as needed for different text types
      ),
      home: const Login(),
    );
  }
}
