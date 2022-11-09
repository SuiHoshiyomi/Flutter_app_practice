import 'package:etherwallet/Shops/restaurant/screens/orders_screen.dart';
import 'package:etherwallet/Shops/restaurant/screens/restaurant_introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/requests/restaurant_info_request.dart';
import '../data/data.dart';
import '../models/cart.dart';
import 'cart_screen.dart';
import 'restaurant_screen.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// var restaurant_info_list = Restaurant_Info.restaurant_info_request();

class _HomeScreenState extends State<HomeScreen> {
  Column _buildRestaurants() {
    final restaurantList = <Widget>[];
    for (final restaurant in restaurants) {
      restaurantList.add(
        GestureDetector(
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => RestaurantIntroductionScreen(restaurant: restaurant),
          //   ),
          // ),
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => RestaurantScreen(restaurant: restaurant),
          //   ),
          // ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[200]!,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: restaurant.imageUrl!,
                    child: Image(
                      height: 150,
                      width: 150,
                      image: AssetImage(
                        restaurant.imageUrl!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  // width: 10,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // RatingStars(
                      //   rating: restaurant.rating,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "introduction",
                        // restaurant.address!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      children: restaurantList,
    );
  }

  @override
  Widget build(BuildContext context) {

    var cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/wallet_main_page');
          },
          icon: Icon(
            Icons.account_circle,
          ),
          iconSize: 30,
        ),
        title: Text(
          'Restaurants',
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => orders_screen(),
              ),
              // MaterialPageRoute(
              //   builder: (_) => CartScreen(restaurant_id: 0,),
              // ),
            ),
            child: Text(
              'Orders (${currentUser.orders!.length})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: restaurant_info_request(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            List<Widget> children;
            if(snapshot.hasData){
              children = <Widget>[
                ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Search food or restaurants',
                          hintStyle: TextStyle(
                            fontSize: 22,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          suffix: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.clear,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // RecentOrders(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Restaurants',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        _buildRestaurants(),
                      ],
                    )
                  ],
                )
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}


Future<List> restaurant_info_request() async {
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
