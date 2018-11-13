import 'package:celer_sms/pages/splash.dart';
import 'package:flutter/material.dart';

//THEME Color(0xFF7D4EEC)/Dark/0xFF512CA9
//YELLOW Color(0xFFFFBC00)
void main() => runApp(new CelerSMS());

class CelerSMS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celer SMS',
      theme: ThemeData(
        primaryColor: Color(0xFF7D4EEC)
      ),
      home: SplashPage()
    );
  }
}
