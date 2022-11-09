import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Restaurant_Info {
  // Restaurant_Info({required this.account, required this.password});

  static Future<List> restaurant_info_request() async {
    var client = http.Client();
    try {
      var url = Uri.parse('http://210.70.80.14/restaurant_info.php');
      var response = await http.post(url, body: {});
      var response_body = utf8.decode(response.bodyBytes).split("<br>");
      print("restaurant_info_request response: ${response.statusCode}");
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // print(decodedResponse['account']);
      return response_body;
    } finally {
      client.close();
    }
  }
}
