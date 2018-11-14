import 'package:celer_sms/pages/home.dart';
import 'package:celer_sms/utils/time-utils.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            TextFormField(
              onSaved: (String my){

              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter web service title",
                  labelText: "Title",
                  hintStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500 )
              ),
            ),
            TextFormField(
              onSaved: (String my){
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter rest api url",
                  labelText: "Url",
                  hintStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500 )
              ),
            ),
            Container(
              child: Text("Optional: Enter the Sync scheme"),
            ),
            TextFormField(
              onSaved: (String my){
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter rest api url",
                  labelText: "Secret key",
                  hintStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500 )
              ),
            )
          ],
        ),
      ),
    );
  }
}
