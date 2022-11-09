import 'food.dart';
import 'restaurant.dart';

class Order {
    Order({
    // required this.id,
    required this.restaurant_id,
    this.date,
    this.restaurant,
    this.food,
    this.quantity,
  });

  // final int id;
  final String restaurant_id;
  final Restaurant? restaurant;
  final Food? food;
  final String? date;
  final int? quantity;
}
