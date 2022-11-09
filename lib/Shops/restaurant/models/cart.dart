import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';

class CartModel extends ChangeNotifier {
  List<Product> cart = [
    // Product(id: 0, restaurant: "restaurant0", name: "burger", qty: 3, price: 50, imgUrl: '/images/burger.jpg'),
    // Product(id: 1, restaurant: "restaurant1", name: "salmon", qty: 1, price: 20, imgUrl: '/images/salmon.jpg')
  ];

  double totalCartValue = 0;

  int get total => cart.length;

  void addProduct(product) {
    // int index = cart.indexWhere((i){
    //   print(i.id);
    //   return i.id == product.id;
    // });
    int index = cart.indexWhere((i) => i.id == product.id);
    if (index != -1){
      int temp_qty = cart[index].qty;
      updateProduct(product, product.qty + temp_qty);
    }
    else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = qty;
    if (cart[index].qty == 0)
      removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.price * f.qty;
    });
  }
}

class Product {
  int id;
  int restaurant_id;
  String restaurant;
  String name;
  String? imgUrl;
  double price;
  int qty;

  Product({required this.id, required this.restaurant_id, required this.restaurant, required this.name, required this.price, required this.qty, this.imgUrl});
}
