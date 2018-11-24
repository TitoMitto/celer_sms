import 'dart:async';
import 'dart:convert';

import 'package:celer_sms/utils/platform_utils.dart';

class SettingsManager {
  SettingsManager();
  Future<bool> hasPhoneNumber() async {
    String phoneNumber = await getPhoneNumber();
    return (phoneNumber == null || phoneNumber == "")?  false : true;
  }

  Future<bool> hasSettings() async {
    Map settings = await getUserSettings();
    return (settings == null || settings.isEmpty)?  false : true;
  }


  Future<bool> setPhoneNumber(String phoneNumber) async {

    return await setSettings("phoneNumber", phoneNumber);
  }

  Future<String> getPhoneNumber() async {
    return await getSettings("phoneNumber");
  }


  Future<bool> setUserSettings(Map settings) async {
    String settingsAsString = json.encode(settings);
    return await setSettings("settings", settingsAsString);
  }

  Future<Map> getUserSettings() async {
    String settingsAsString = await getSettings("settings");
    return (settingsAsString != null && settingsAsString != "")? json.decode(settingsAsString):null;
  }

}