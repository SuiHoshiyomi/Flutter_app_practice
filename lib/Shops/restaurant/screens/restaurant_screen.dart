import 'package:etherwallet/Shops/restaurant/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../widgets/rating_stars.dart';
import '../models/cart.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key, this.restaurant}) : super(key: key);

  final List? restaurant;

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Center _buildMenuItem(List menuItem, CartModel cart, int? restaurant_id, String? restaurant_name) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(menuItem[3]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black87.withOpacity(0.3),
                  Colors.black54.withOpacity(0.3),
                  Colors.black38.withOpacity(0.3),
                ],
                stops: [0.1, 0.5, 0.7, 0.6],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Positioned(
            bottom: 65,
            child: Column(
              children: [
                Text(
                  menuItem[1],
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  '\$${menuItem[2]}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            // right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  cart.addProduct(Product(
                    id: int.parse(menuItem[0]),
                    restaurant_id: restaurant_id!,
                    restaurant: restaurant_name!,
                    name: menuItem[1],
                    imgUrl: menuItem[3],
                    qty: 1,
                    price: double.parse(menuItem[2]),
                  ));
                },
                icon: Icon(
                  Icons.add,
                ),
                iconSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var cart = context.watch<CartModel>();
    List menu = widget.restaurant![3].split('、');

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List>(
          future: food_info_request(widget.restaurant![3]),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            List<Widget> children;
            if(snapshot.hasData){
              // print("restaurant screen: ${snapshot.data![0]}");
              print("restaurant screen: ${snapshot.data![0].split(",")}");
              children = <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.restaurant![1],
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Type',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            // RatingStars(rating: widget.restaurant!.rating),
                            SizedBox(
                              height: 26,
                            ),
                            Text(
                              // "Introduction",
                              widget.restaurant![3],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          crossAxisCount: 2,
                          children:
                          List.generate(menu.length, (index) {
                            // final food = menu[index];
                            return _buildMenuItem(snapshot.data![index].split(","), cart, int.parse(widget.restaurant![0]), widget.restaurant![1], );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ];
            }else if (snapshot.hasError) {
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
        floatingActionButton: Container(
          child: FittedBox(
            child: Stack(
              alignment: Alignment(1.4, -1.5),
              children: [
                FloatingActionButton(
                  // onPressed: () => Navigator.pushNamed(context, '/cart_screen'),
                  onPressed: (){
                    if(cart.cart.length>=1){
                      Navigator.of(context).pushNamed(
                        '/cart_screen',
                        arguments: (widget.restaurant),
                      );
                      // Navigator.of(context).pushNamed(
                      //     '/cart_screen',
                      //     arguments: (cart.cart[0].restaurant_id),
                      // );
                    }
                  },
                  child: Icon(Icons.shopping_cart),
                  backgroundColor: Colors.deepOrange,
                ),
                if(cart.cart.length>=1)
                Container(
                  child: Center(
                    // Here you can put whatever content you want inside your Badge
                    child: Text("${cart.cart.length}", style: TextStyle(color: Colors.white)),
                  ),
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                  decoration: BoxDecoration( // This controls the shadow
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 5,
                          color: Colors.black.withAlpha(50))
                    ],
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,  // This would be color of the Badge
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future<List> food_info_request(String food_id) async {
  var client = http.Client();
  try {
    var url = Uri.parse('http://210.70.80.14/menu_info.php');
    var response = await http.post(url, body: {"id": food_id});
    var response_body = utf8.decode(response.bodyBytes).split("<br>");
    // print("restaurant_info_request response: ${response.statusCode}");
    // print("restaurant_info_request length: ${response_body.take((response_body.length-1)).toList()}");
    // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // print(decodedResponse['account']);
    return response_body.take((response_body.length-1)).toList();
  } finally {
    client.close();
  }
}


