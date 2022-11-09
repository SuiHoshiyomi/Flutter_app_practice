import 'package:etherwallet/user/webview_page/signin_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:etherwallet/animation/ScaleRoute.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            // Flexible(
            //   flex: 1,
            //   child: InkWell(
            //     child: Container(
            //       child: Align(
            //         alignment: Alignment.topLeft,
            //         child: Icon(Icons.close),
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            Flexible(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   width: 230,
                  //   height: 100,
                  //   alignment: Alignment.center,
                  //   child: Image.asset(
                  //     "assets/images/menus/ic_food_express.png",
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // TextField(
                  //   showCursor: true,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //       borderSide: BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //     filled: true,
                  //     prefixIcon: Icon(
                  //       Icons.account_box,
                  //       color: Color(0xFF666666),
                  //       size: defaultIconSize,
                  //     ),
                  //     fillColor: Color(0xFFF2F3F5),
                  //     hintStyle: TextStyle(
                  //         color: Color(0xFF666666),
                  //         fontFamily: defaultFontFamily,
                  //         fontSize: defaultFontSize),
                  //     hintText: "Student ID",
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  // TextField(
                  //   showCursor: true,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //       borderSide: BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //     filled: true,
                  //     prefixIcon: Icon(
                  //       Icons.lock_outline,
                  //       color: Color(0xFF666666),
                  //       size: defaultIconSize,
                  //     ),
                  //     // suffixIcon: Icon(
                  //     //   Icons.remove_red_eye,
                  //     //   color: Color(0xFF666666),
                  //     //   size: defaultIconSize,
                  //     // ),
                  //     fillColor: Color(0xFFF2F3F5),
                  //     hintStyle: TextStyle(
                  //       color: Color(0xFF666666),
                  //       fontFamily: defaultFontFamily,
                  //       fontSize: defaultFontSize,
                  //     ),
                  //     hintText: "Password",
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text(
                  //     "Forgot your password?",
                  //     style: TextStyle(
                  //       color: Color(0xFF666666),
                  //       fontFamily: defaultFontFamily,
                  //       fontSize: defaultFontSize,
                  //       fontStyle: FontStyle.normal,
                  //     ),
                  //     textAlign: TextAlign.end,
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  SignInButtonWidget(),
                  SizedBox(
                    height: 2,
                  ),
                  // FacebookGoogleLogin()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInButtonWidget extends StatelessWidget {

  // final authorizationEndpoint =
  // Uri.parse('http://192.168.18.9:5000/oauth/authorize?response_type=code&client_id=fshn0gpecCmguZ1WCapr8DxY&scope=profile');
  final authorizationEndpoint =
  Uri.parse('https://adfs.asia.edu.tw/adfs/oauth2/authorize/?client_id=edcff7d0-7263-46d3-9047-c6e745a3bab5&response_type=code&scope=openid');
  final tokenEndpoint = Uri.parse('https://adfs.asia.edu.tw/adfs/oauth2/token');
  final identifier = 'f1ac2bc5-ebb0-4a61-800d-98eb0515fbe1';
  final secret = 'KYO92X-32FIw1NZOIK7Yp6MAOC_0TCJQ7_3PdgSc';
  final redirectUrl = Uri.parse('https://auth.asia.edu.tw/adfs.php');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFfbab66),
          ),
          BoxShadow(
            color: Color(0xFFf7418c),
          ),
        ],
        gradient: new LinearGradient(
            colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Color(0xFFf7418c),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              "SIGN IN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: "WorkSansBold"),
            ),
          ),
          onPressed: () {
            var grant = oauth2.AuthorizationCodeGrant(
                identifier, authorizationEndpoint, tokenEndpoint,
                secret: secret);
            var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);
            // Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => signin_webview(grant, authorizationUrl.toString())));
            // Navigator.of(context)
            //     .pushNamed('/')
          }
        ),
    );
  }
}

class FacebookGoogleLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.black12,
                            Colors.black54,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "Or",
                      style: TextStyle(
                          color: Color(0xFF2c2b2b),
                          fontSize: 16.0,
                          fontFamily: "WorkSansMedium"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.black12,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 40.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFf7418c),
                      ),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFf7418c),
                      ),
                      child: new Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
