import 'dart:convert';

import 'package:http/http.dart' as http;

class SecondOauth {
  // SecondOauth({required this.oauth_token, required this.applicationId});

  // final String oauth_token;
  // final String applicationId;

  static Future<Map> second_oauth_post(String oauth_token) async {
    var oauth_url = 'http://192.168.18.16/exec_cmd.php';
    // var oauth_token = '2h9iCnKEVUzvBpr7pUUnqHNRCvYyjZQ2fHBcqZ7Aea';

    var client = http.Client();
    try {
      var url = Uri.parse(oauth_url);
      var response = await http.post(url, body: {'token': oauth_token});
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes).replaceAll('\'', "\"")) as Map;
      return decodedResponse;
    } finally {
      client.close();
    }
  }
}
