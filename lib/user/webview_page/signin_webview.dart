import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:etherwallet/first_page.dart';
// import 'package:etherwallet/second_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/configuration_service.dart';

// import 'main.dart';

class signin_webview extends StatelessWidget {
  var grant;
  String? url;
  signin_webview(this.grant, this.url);

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Login Page'),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) async {
              if (request.url.startsWith('https://docs.flutter.dev/get-started/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }else if(request.url.startsWith('https://auth.asia.edu.tw/adfs.php')){
                var responseUrl = Uri.parse(request.url);
                var client = await grant.handleAuthorizationResponse(responseUrl.queryParameters);
                var jwt = client.credentials.accessToken.split('.');
                print("JWT-1: ${utf8.decode(base64.decode(jwt[0]))}");
                print("JWT-2.: ${utf8.decode(base64.decode(base64.normalize(jwt[1])))}");
                Navigator.popAndPushNamed(context, '/');


                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => second_page(authz_url: code.toString(),)));
                return NavigationDecision.prevent;
              }
              // print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        }));
  }

  Future<void> authz_access_token() async {
    var headers = {
      'Authorization': 'Bearer NYF40nVabwhs5AYDKFitfjEzkMqaLatEgPJHDDpzQC',
    };

    var url = Uri.parse('http://192.168.18.9:5000/api/me');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
    print(res.body);
  }
}