import 'package:flutter/cupertino.dart';

import '../models/food.dart';
import '../models/order.dart';
import '../models/restaurant.dart';
import '../models/user.dart';

// Food
final _burrito =
Food(id: 0, imageUrl: 'assets/images/burrito.jpg', name: 'Burrito', price: 10);
final _steak =
Food(id: 1, imageUrl: 'assets/images/steak.jpg', name: 'Steak', price: 15);
final _pasta =
Food(id: 2, imageUrl: 'assets/images/pasta.jpg', name: 'Pasta', price: 20);
final _ramen =
Food(id: 3, imageUrl: 'assets/images/ramen.jpg', name: 'Ramen', price: 25);
final _pancakes =
Food(id: 4, imageUrl: 'assets/images/pancakes.jpg', name: 'Pancakes', price: 30);
final _burger =
Food(id: 5, imageUrl: 'assets/images/burger.jpg', name: 'Burger', price: 35);
final _pizza =
Food(id: 6, imageUrl: 'assets/images/pizza.jpg', name: 'Pizza', price: 40);
final _salmon = Food(
    id: 7, imageUrl: 'assets/images/salmon.jpg', name: 'Salmon Salad', price: 45);

// Restaurants
final _restaurant0 = Restaurant(
  id: 0,
  imageUrl: 'assets/images/restaurant0.jpg',
  name: 'Restaurant 0',
  address: '200 Main St, New York, NY',
  blockchain_address: '0xc2458e81a94e8d477fe1ca03eb3b083a49c55529',
  menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant1 = Restaurant(
  id: 1,
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Restaurant 1',
  address: '201 Main St, New York, NY',
  blockchain_address: '0x0000001',
  menu: [_steak, _pasta, _ramen, _pancakes, _burger, _pizza],
);
final _restaurant2 = Restaurant(
  id: 2,
  imageUrl: 'assets/images/restaurant2.jpg',
  name: 'Restaurant 2',
  address: '202 Main St, New York, NY',
  blockchain_address: '0x0000002',
  menu: [_steak, _pasta, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant3 = Restaurant(
  id: 3,
  imageUrl: 'assets/images/restaurant3.jpg',
  name: 'Restaurant 3',
  address: '203 Main St, New York, NY',
  blockchain_address: '0x0000003',
  menu: [_burrito, _steak, _burger, _pizza, _salmon],
);
final _restaurant4 = Restaurant(
  id: 4,
  imageUrl: 'assets/images/restaurant4.jpg',
  name: 'Restaurant 4',
  address: '204 Main St, New York, NY',
  blockchain_address: '0x0000004',
  menu: [_burrito, _ramen, _pancakes, _salmon],
);

final List<Restaurant> restaurants = [
  _restaurant0,
  _restaurant1,
  _restaurant2,
  _restaurant3,
  _restaurant4,
];

final List<Food> foods = [
  _burrito,
  _steak,
  _pasta,
  _ramen,
  _pancakes,
  _burger,
  _pizza,
  _salmon,
];

// User
final currentUser = User(
  name: 'AAAAA',
  orders: [],
  // cart: [
    // Order(
    //   id: _burrito.id,
    //   date: 'Nov 11, 2019',
    //   food: _burrito,
    //   restaurant: _restaurant1,
    //   quantity: 2,
    // ),
  // ],
);


