import 'package:celer_sms/pages/auth_page.dart';
import 'package:celer_sms/pages/home.dart';
import 'package:celer_sms/tools/settings_manager.dart';
import 'package:celer_sms/utils/time-utils.dart';
import 'package:celer_sms/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SettingsManager settingsManager = SettingsManager();
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }
  void navigate() async {
    if(!await settingsManager.hasSettings()){
      await settingsManager.setSettings({
        "title": appName,
        "apiUrl": apiUrl
      });
    }
    var page = (await settingsManager.hasPhoneNumber())? HomePage():AuthPage();
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context) => page
    ));
  }

  void requestPermissions() async {
    Permission.requestPermissions([PermissionName.SMS,PermissionName.Phone]).then((value){
      setTimeout(navigate, 500);
    });
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
