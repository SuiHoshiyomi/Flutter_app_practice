// import 'package:etherwallet/Shops/restaurant/data/data.dart';
import 'package:etherwallet/Shops/restaurant/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../components/dialog/alert.dart';
// import '../models/food.dart';
// import '../models/order.dart';
// import '../models/restaurant.dart';
// import '../widgets/rating_stars.dart';
// import '../data/data.dart';
import '../models/cart.dart';

class RestaurantIntroductionScreen extends StatefulWidget {
  const RestaurantIntroductionScreen({Key? key, this.restaurant}) : super(key: key);

  final List? restaurant;

  @override
  _RestaurantIntroductionScreenState createState() => _RestaurantIntroductionScreenState();
}

class _RestaurantIntroductionScreenState extends State<RestaurantIntroductionScreen> {
  @override
  Widget build(BuildContext context) {

    var cart = context.watch<CartModel>();

    return WillPopScope(
      onWillPop: () async {
        if(cart.cart.length>=1){
          return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: const Text('返回首頁'),
              content: const Text('清除購物車'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('確認'),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/');
                    cart.cart=[];
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )) ?? false;
        }else{
          Navigator.of(context).popAndPushNamed('/');
          cart.cart=[];
          return false;
        }
      },
      child: new SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.restaurant![4],
                    child: Image.network(
                      widget.restaurant![4],
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                            if(cart.cart.length>=1){
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('返回首頁'),
                                    content: const Text('清除購物車'),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('確認'),
                                        onPressed: () {
                                          Navigator.of(context).popAndPushNamed('/');
                                          cart.cart=[];
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('取消'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }else{
                              Navigator.of(context).popAndPushNamed('/');
                              cart.cart=[];
                            }
                          },
                          // onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                          '產品類型',
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
                      "介紹",
                      // widget.restaurant!.address!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 200,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 150, height: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: Text('點餐'),
                  onPressed: () {
                    print(widget.restaurant![4]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RestaurantScreen(restaurant: widget.restaurant),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
