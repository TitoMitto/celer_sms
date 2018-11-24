import 'package:flutter/services.dart';

const _platform = const MethodChannel('celer_sms.mordeccai.com/messenger');

Future<bool> setSettings(String key,String value) async {
  await _platform.invokeMethod('storeSettings', <String, String>{"key": key, "value": value});
}

Future<String> getSettings(String key) async {
  return await _platform.invokeMethod('getSettings', <String, String>{"key": key});
}

Future<List<dynamic>> getAllMessages() async {
  return await _platform.invokeMethod('getAllMessages');
}