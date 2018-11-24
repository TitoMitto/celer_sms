import 'package:celer_sms/pages/home.dart';
import 'package:celer_sms/tools/settings_manager.dart';
import 'package:celer_sms/widgets/number_entry.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  SettingsManager settingsManager = SettingsManager();
  TextEditingController _phoneNumber = TextEditingController();
  CElement _countryCode;

  void _savePhoneNumber() async {
    if(_phoneNumber.text.trim() != ""){
      await settingsManager.setPhoneNumber(_countryCode.dialCode+""+_phoneNumber.text);
      _navigateToHome();
    }
  }
  void _navigateToHome(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Container(
          height: 250.0,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 225.0,
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Celer SMS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28.0
                        ),
                      ),
                      Text(
                        "Verify phone number",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0
                      ),)
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                NumberEntry(
                  onCountryChange: (value){
                    _countryCode = value;
                  },
                  onFinish: _savePhoneNumber,
                  phoneNumber: _phoneNumber,
                )
              ],
            ),
          ),
          width: double.infinity,
        ),
      ),
    );
  }
}
