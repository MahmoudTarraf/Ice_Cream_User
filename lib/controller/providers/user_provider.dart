// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/controller/Auth/secure_storage_auth.dart';
import 'package:graduation_project/controller/syriatel_cash/messages.dart';
import 'package:graduation_project/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProvider with ChangeNotifier {
  //
  User _thisUser = User(
      email: 'email',
      location: 'location',
      userName: 'userName',
      phoneNumber: 'phoneNumber',
      points: "0",
      totalPurchases: "0");
  static const thisUrl = Config.url;
  String? _email;
  User get getUser => _thisUser;
  //
  void setUser(User thatUser) {
    _thisUser = thatUser;
    notifyListeners();
  }

  Future<void> changeUserName(String newUserName, BuildContext context) async {
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();
    final body = {
      "username": _thisUser.userName,
      "email": _thisUser.email,
      "newUsername": newUserName
    };
    final response = await http.post(
      Uri.parse('${Config.url}/changeusername/'),
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var temp = User(
          email: _thisUser.email,
          location: _thisUser.location,
          userName: newUserName,
          phoneNumber: _thisUser.phoneNumber,
          points: _thisUser.points,
          totalPurchases: _thisUser.totalPurchases);
      setUser(temp);
      showSuccess(context, AppLocalizations.of(context)!.all_done,
          'UserName Changed to $newUserName!');
    } else {
      showError(context, AppLocalizations.of(context)!.error, response.body);
    }
    notifyListeners();
  }

  //
  Future<void> changePhonethatNumber(
      String newPhoneNumber, BuildContext context) async {
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();
    final body = {
      "phonenumber": newPhoneNumber,
      "email": _thisUser.email,
      "username": _thisUser.userName
    };

    final response = await http.post(
      Uri.parse('${Config.url}/changephonenumber/'),
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var temp = User(
          email: _thisUser.email,
          location: _thisUser.location,
          userName: _thisUser.userName,
          phoneNumber: newPhoneNumber,
          points: _thisUser.points,
          totalPurchases: _thisUser.totalPurchases);
      setUser(temp);
      showSuccess(context, AppLocalizations.of(context)!.all_done,
          'Phone Number Changed to $newPhoneNumber!');
    } else {
      showError(context, AppLocalizations.of(context)!.error, response.body);
    }
    notifyListeners();
  }

//
  Future<void> changethatEmail(String newEmail, BuildContext context) async {
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();

    final body = {
      "newEmail": newEmail,
      "username": _thisUser.userName,
      "email": _thisUser.email
    };
    final response = await http.post(
      Uri.parse('${Config.url}/changeemail/'),
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var temp = User(
          email: newEmail,
          location: _thisUser.location,
          userName: _thisUser.userName,
          phoneNumber: _thisUser.phoneNumber,
          points: _thisUser.points,
          totalPurchases: _thisUser.totalPurchases);
      setUser(temp);
      showSuccess(context, AppLocalizations.of(context)!.all_done,
          'Phone Number Changed to $newEmail!');
    } else {
      showError(context, AppLocalizations.of(context)!.error, response.body);
    }
    notifyListeners();
  }
//

  Future<void> getUserDetails() async {
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();
    final response = await http.get(
      Uri.parse('${Config.url}getuser/$_email'),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      var temp = User(
          email: responseData['email'],
          location: responseData['location'],
          userName: responseData['username'],
          phoneNumber: responseData['phonenumber'],
          points: responseData['points'],
          totalPurchases: responseData['total_purchases']);
      setUser(temp);
    }
    notifyListeners();
  }

  Future<void> updatePurchase(int newPurchase, BuildContext context) async {
    print(newPurchase);
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();
    print(_email);
    final body = {
      "new_purchases": newPurchase.toString(),
      "email": _thisUser.email,
    };

    final response = await http.post(
      Uri.parse('${Config.url}/updatepurchases/'),
      body: body,
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var temp = User(
          email: _thisUser.email,
          location: _thisUser.location,
          userName: _thisUser.userName,
          phoneNumber: _thisUser.phoneNumber,
          points: _thisUser.points,
          totalPurchases: newPurchase.toString());
      setUser(temp);
    } else {}
    notifyListeners();
  }

  Future<void> updatePoints(int newPoints, BuildContext context) async {
    final secureStorage = SecureStorageService();
    _email = await secureStorage.getEmail();
    print(newPoints);
    final body = {
      "new_points": newPoints.toString(),
      "email": _thisUser.email,
    };

    final response = await http.post(
      Uri.parse('${Config.url}/updatepoints/'),
      body: body,
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var temp = User(
          email: _thisUser.email,
          location: _thisUser.location,
          userName: _thisUser.userName,
          phoneNumber: _thisUser.phoneNumber,
          points: newPoints.toString(),
          totalPurchases: _thisUser.totalPurchases);
      setUser(temp);
    } else {}
    notifyListeners();
  }
}
