// ignore_for_file: unused_local_variable

import 'package:graduation_project/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartModel> _cartList = [];
  List<CartModel> get iceCreams => _cartList;

  int sum = 0;

  void addCartItem({
    required String image,
    required int price,
    required String title,
    required int count,
    required String details,
  }) {
    var condition = false;
    if (_cartList.isNotEmpty) {
      for (var element in _cartList) {
        if (element.title == title && element.details == details) {
          element.count += 1;
          condition = true;
        }
      }
      if (condition == false) {
        _cartList.add(
          CartModel(
            details: details,
            count: count,
            image: image,
            title: title,
            price: price,
          ),
        );
      }
    } else {
      _cartList.add(
        CartModel(
          details: details,
          count: count,
          image: image,
          title: title,
          price: price,
        ),
      );
    }

    notifyListeners();
    return;
  }

  void deleteCartItem(String title, int count) {
    _cartList.removeWhere(
      (cartItem) => cartItem.title == title && cartItem.count == count,
    );
    for (int i = 0; i < _cartList.length; i++) {
      var thisItem = _cartList[i];
    }
    notifyListeners();
  }

  int get getTotalPrice {
    sum = 0;
    for (var element in _cartList) {
      sum += element.price * element.count;
    }
    return sum;
  }

  updateSum(int value) {
    sum += value;
    getTotalPrice;
    notifyListeners();
  }
}
