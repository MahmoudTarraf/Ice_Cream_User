// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:graduation_project/controller/Auth/secure_storage_auth.dart';
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/controller/syriatel_cash/messages.dart';
import 'package:graduation_project/controller/providers/user_provider.dart';
import 'package:graduation_project/model/user_model.dart';
import 'package:graduation_project/view/screens/home_page_screens/home_page_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator with ChangeNotifier {
  static const thisUrl = Config.url;

  Future<void> signup({
    required BuildContext context,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
//
    final url = Uri.parse('$thisUrl' 'signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "username": userName,
      "password": password,
      "email": email,
      "phonenumber": phoneNumber,
      "location": "canada",
      "points": "0",
      "total_purchases": "0"
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      showSuccess(
        context,
        AppLocalizations.of(context)!.log_in_now,
        AppLocalizations.of(context)!.sign_up_success,
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final temp = User(
        totalPurchases: responseData["user"]["total_purchases"],
        points: responseData["user"]["points"],
        email: responseData["user"]["email"],
        location: responseData["user"]["location"],
        phoneNumber: responseData["user"]["phonenumber"],
        userName: responseData["user"]["username"],
      );
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setUser(temp);
      final secureStorage = SecureStorageService();

      await secureStorage.storeEmail(
        responseData["user"]["email"],
      );
    } else {
      showError(context, AppLocalizations.of(context)!.sign_up_failed,
          '${response.reasonPhrase}');
    }
  }

  Future<void> login({
    required BuildContext context,
    required String password,
    required String userName,
    required bool? condition,
  }) async {
    final url = Uri.parse('$thisUrl' 'login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "username": userName,
      "password": password,
    });

    final response = await http.post(url, headers: headers, body: body);
    // Handle the response
    if (response.statusCode == 200) {
      showSuccess(
        context,
        AppLocalizations.of(context)!.welcome,
        AppLocalizations.of(context)!.log_in_success,
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final temp = User(
        totalPurchases: responseData["user"]["total_purchases"],
        points: responseData["user"]["points"],
        email: responseData["user"]["email"],
        location: responseData["user"]["location"],
        phoneNumber: responseData["user"]["phonenumber"],
        userName: responseData["user"]["username"],
      );
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setUser(temp);
      final secureStorage = SecureStorageService();
      await secureStorage.storeThatCondition("True");

      await secureStorage.storeEmail(
        responseData["user"]["email"],
      );

      if (condition == true) {
        final secureStorage = SecureStorageService();
        await secureStorage.storeCondition("True");
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // Request failed
      showError(context, AppLocalizations.of(context)!.log_in_failed,
          '${response.reasonPhrase}');
    }
  }
}
