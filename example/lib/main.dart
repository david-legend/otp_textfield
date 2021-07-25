import 'package:example/verification_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

 const Color accentPurpleColor = Color(0xFF6A53A1);
 const Color accentPinkColor = Color(0xFFF99BBD);
 const Color accentDarkGreenColor = Color(0xFF115C49);
 const Color accentYellowColor = Color(0xFFFFB612);
 const Color accentOrangeColor = Color(0xFFEA7A3B);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VerificationScreen1()
      // VerificationScreen2(),
    );
  }
}


