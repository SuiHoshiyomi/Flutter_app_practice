import 'cart.dart';
import 'order.dart';

class User {
  User({
    this.name,
    this.orders,
    // this.cart,
  });

  final String? name;
  final List<Order>? orders;
  // late final List<Order>? cart;
}
