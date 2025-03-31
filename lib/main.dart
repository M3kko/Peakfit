import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PeakFitApp());
}

class PeakFitApp extends StatelessWidget {
  const PeakFitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeakFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
