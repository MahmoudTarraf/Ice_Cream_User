// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/controller/Auth/secure_storage_auth.dart';
import 'package:graduation_project/controller/syriatel_cash/messages.dart';
import 'package:graduation_project/model/order_model.dart';

import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  static const thisurl = Config.url;
  List<OrderModel> _allOrderList = [];
  List<OrderModel> finishedOrderList = [];
  List<OrderModel> unFinishedOrderList = [];
  List<OrderModel> get theseOrders => _allOrderList;

  Future getOrderByEmail(BuildContext context) async {
    final secureStorage = SecureStorageService();
    final email = await secureStorage.getEmail();
    _allOrderList = [];
    finishedOrderList = [];
    unFinishedOrderList = [];
    final response = await http.get(
      Uri.parse('${thisurl}getOrderByEmail/$email'),
      headers: {'Content-Type': 'application/json'},
    );
    final selectedData = json.decode(response.body) as List;

    if (response.statusCode == 200) {
      for (int i = 0; i < selectedData.length; i++) {
        _allOrderList.add(
          OrderModel(
            email: selectedData[i]['email'],
            userName: 'username',
            phoneNumber: 'phoneNumber',
            location: 'location',
            operationNumber: selectedData[i]['operationNumber'],
            totalPrice: selectedData[i]['totalPrice'],
            details: selectedData[i]['details'],
            delivered: selectedData[i]['delivered'],
          ),
        );
      }

      finishedOrderList = _allOrderList
          .where(
            (element) => element.delivered == "Yes",
          )
          .toList();
      for (int i = 0; i < _allOrderList.length; i++) {
        if (_allOrderList[i].delivered == "No" ||
            _allOrderList[i].delivered == "Pending") {
          unFinishedOrderList.add(
            OrderModel(
              email: _allOrderList[i].email,
              userName: _allOrderList[i].userName,
              phoneNumber: _allOrderList[i].phoneNumber,
              location: _allOrderList[i].location,
              operationNumber: _allOrderList[i].operationNumber,
              totalPrice: _allOrderList[i].totalPrice,
              details: _allOrderList[i].details,
              delivered: _allOrderList[i].delivered,
            ),
          );
        }
      }
    } else {
      showError(context, 'Error!', 'Couldnt get ALl Orders');
    }

    notifyListeners();
  }

  List<OrderModel> get getfinishedOrderList => finishedOrderList;
  List<OrderModel> get getUnFinishedOrderList => unFinishedOrderList;
//
}
