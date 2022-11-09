import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login {
  Login({required this.account, required this.password, this.actions});

  final String account;
  final String password;
  final List<Widget>? actions;

  Future<Map> loginPost(String account, String password) async {
    var client = http.Client();
    try {
      var url = Uri.parse('http://192.168.56.101:8080/dart_post.php');
      var response = await http.post(url, body: {'account': account, 'pwd': password});
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // print(decodedResponse['account']);
      return decodedResponse;
    } finally {
      client.close();
    }
  }
}
