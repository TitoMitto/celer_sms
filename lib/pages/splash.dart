import 'package:celer_sms/pages/home.dart';
import 'package:celer_sms/utils/time-utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    setTimeout(navigate, 2000);
  }
  void navigate(){
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context)=> HomePage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset("assets/images/icon.png",width: 80.0,height: 80.0),),
      ),
    );
  }
}
