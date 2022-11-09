import 'package:etherwallet/wallet_main_page.dart';
import 'package:flutter/material.dart';

import 'Shops/restaurant/screens/cart_screen.dart';
import 'Shops/restaurant/screens/home_screen.dart';

class app_main_page extends StatefulWidget {
  const app_main_page({Key? key}) : super(key: key);

  @override
  State<app_main_page> createState() => _app_main_pageState();
}

class _app_main_pageState extends State<app_main_page> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // CartScreen(restaurant_id: 0,),
    // WalletMainPage("My Wallet"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFfd5352),
        onTap: _onItemTapped,
      ),
    );
  }
}

