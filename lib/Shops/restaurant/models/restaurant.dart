import 'food.dart';

class Restaurant {
  Restaurant({
    this.id,
    this.imageUrl,
    this.name,
    this.address,
    this.blockchain_address,
    this.menu,
  });

  final int? id;
  final String? imageUrl;
  final String? name;
  final String? address;
  final String? blockchain_address;
  final List<Food>? menu;
}
