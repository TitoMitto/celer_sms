import 'dart:convert';
import 'dart:io';
import 'package:celer_sms/tools/settings_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  SettingsManager settingsManager = SettingsManager();
  Future saveMessage(Map body) async {
    Map settings = await settingsManager.getSettings();
    String _apiUrl = settings["apiUrl"];
    print("$_apiUrl");
    return http.post(_apiUrl, body: body, headers: {
      HttpHeaders.CONTENT_TYPE : "application/x-www-form-urlencoded"
    });
  }
}