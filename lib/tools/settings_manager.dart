import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  SettingsManager();
  Future<bool> hasPhoneNumber() async {
    String phoneNumber = await getPhoneNumber();
    return (phoneNumber == null || phoneNumber == "")?  false : true;
  }

  Future<bool> hasSettings() async {
    Map settings = await getSettings();
    return (settings == null || settings.isEmpty)?  false : true;
  }

  Future<String> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phoneNumber");
  }

  Future<bool> setPhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNumber", phoneNumber);
    return await prefs.commit();
  }

  Future<bool> setSettings(Map settings) async {
    String settingsAsString = json.encode(settings);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("settings", settingsAsString);
    return await prefs.commit();
  }

  Future<Map> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String settingsAsString = prefs.getString("settings");

    return (settingsAsString != null && settingsAsString != "")? json.decode(settingsAsString):null;
  }

}