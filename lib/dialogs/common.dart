import 'dart:async';

import 'package:flutter/material.dart';

showToast(String msg){
  /*Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1
  );*/
}



Future<Null> alert(context, title, body) async {
  return showDialog<Null>(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK", style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}


Future<Null> confirm(context, title, body, callback) async {
  return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new Text(body),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}

Future<Map> confirmDeletion(context, title, body) async {
  bool isChecked = false;
  return showDialog<Map>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(body),
                new Row(
                  children: <Widget>[
                    new Checkbox(value: isChecked, onChanged: (checked){
                      isChecked = checked;
                    })
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop({
                  "isOk": false
                });
              },
            ),
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop({
                  "isOk": true,
                  "isChecked": isChecked
                });
              },
            ),
          ],
        );
      }
  );
}