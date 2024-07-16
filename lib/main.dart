import 'package:assessment/enter_your_details.dart';
import 'package:assessment/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main()  {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}









