import 'order.dart';

class Food {
  Food({
    required this.id,
    this.imageUrl,
    this.name,
    required this.price,
  });

  final int id;
  final String? imageUrl;
  final String? name;
  final double price;
}
