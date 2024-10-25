import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/gender_prediction.dart';
import 'screens/age_prediction.dart';
import 'screens/university_list.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tool App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/gender': (context) => const GenderPredictionScreen(),
        '/age': (context) => const AgePredictionScreen(),
        '/universities': (context) => const UniversitiesScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}