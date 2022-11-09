import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter_user_profile/pages/edit_description.dart';
// import 'package:flutter_user_profile/pages/edit_email.dart';
// import 'package:flutter_user_profile/pages/edit_image.dart';
// import 'package:flutter_user_profile/pages/edit_name.dart';
// import 'package:flutter_user_profile/pages/edit_phone.dart';
// import '../user/user.dart';
import '../widgets/display_image_widget.dart';
// import '../user/user_data.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final user = UserData.myUser;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                // navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
                onPressed: () {},
              )),
          buildUserInfoDisplay("Test Name", 'Name'),
          buildUserInfoDisplay("23323456", 'Student ID'),
          buildUserInfoDisplay("105021019@gm.asia.edu.tw", 'Email'),
          buildUserInfoDisplay("0xaddress", 'Address'),
          buildAddressQRcode("0xaddress", mediaQuery),
          // Expanded(
          //   child: buildAbout(user),
          //   flex: 4,
          // ),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  // Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
  Widget buildUserInfoDisplay(String getValue, String title) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              // navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  Widget buildAddressQRcode(String address, mediaQuery) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address QRcode",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(
                    children: [
                  if (address != null &&
                  (mediaQuery.orientation == Orientation.portrait || kIsWeb))
                    Container(
                      height: 150,
                      width: 150,
                      child: QrImage(
                        data: address!,
                        size: 150.0,
                      ),
                    ),
                  ]
                )
              )
            ],
          ));
  

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
