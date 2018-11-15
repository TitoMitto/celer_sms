import 'package:celer_sms/pages/home.dart';
import 'package:celer_sms/tools/settings_manager.dart';
import 'package:celer_sms/utils/time-utils.dart';
import 'package:celer_sms/values/strings.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsManager settingsManager = SettingsManager();
  TextEditingController _title = TextEditingController();
  TextEditingController _apiUrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _displaySettings();
  }

  void _displaySettings() async {
    if(await settingsManager.hasSettings()){
      Map settings = await settingsManager.getSettings();
      _title.text = settings["title"];
      _apiUrl.text = settings["apiUrl"];
    }
  }

  _saveSettings() async {
    settingsManager.setSettings({
      "title": _title.text,
      "apiUrl": _apiUrl.text
    }).then((value){
      Flushbar()
        ..title = "Successful"
        ..message = "Settings saved successfuly"
        ..backgroundColor = Colors.green
        ..shadowColor = Colors.green[800]
        ..duration = Duration(seconds: 2)
        ..show(context);
    });
  }

  _resetSettings(){
    setState(() {
      _title.text = appName;
      _apiUrl.text = apiUrl;
    });
    settingsManager.setSettings({
      "title": appName,
      "apiUrl": apiUrl
    }).then((value){
      Flushbar()
        ..title = "Successful"
        ..message = "Settings reset successfuly"
        ..backgroundColor = Colors.green
        ..shadowColor = Colors.green[800]
        ..duration = Duration(seconds: 2)
        ..show(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "All incoming messages will be published to the following RESTful service.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                controller: _title,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter web service title",
                    labelText: "Title",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                controller: _apiUrl,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter rest api url",
                    labelText: "Api url",
                    helperText: "where to send messages"
                ),
              ),
            ),
/*            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Text(
                "Defined JSON keys to send to the RESTful service as sms payload.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter sender key",
                    labelText: "Sender key",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter message key",
                  labelText: "Message key",
                  helperText: "key for message body"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter receiver key",
                  labelText: "Reveiver key",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Text(
                "Defined JSON keys for sms timestamps.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter sent time key",
                  labelText: "Sent time key",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter received time key",
                  labelText: "Received time key",
                ),
              ),
            ),*/
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left:10.0, right: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: _resetSettings,
                      child: Text("RESET", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                      color: Colors.black54,
                      height: 45.0,

                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: _saveSettings,
                      child: Text("SAVE", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                      color: Theme.of(context).primaryColor,
                      height: 45.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
