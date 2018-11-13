import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  String apiUrl = "http://1710edd9.ngrok.io";
  Future saveMessage(Map body) async {
    var url = "$apiUrl/messages";
    print("Api url $url");
    return http.post(url, body: body, headers: {
      HttpHeaders.CONTENT_TYPE : "application/x-www-form-urlencoded"
    });
  }
}