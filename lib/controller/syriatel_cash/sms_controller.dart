// , use_build_context_synchronously
// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/controller/Auth/secure_storage_auth.dart';
import 'package:graduation_project/controller/providers/providers.dart';
import 'package:graduation_project/controller/syriatel_cash/messages.dart';
import 'package:graduation_project/model/cart_model.dart';
import 'package:graduation_project/model/user_model.dart';
import 'package:graduation_project/view/screens/home_page_screens/home_page_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const url = Config.url;
const thisPhoneNumber = Config.phoneNumber;
Future<void> checkOrderConfirmationAndPlaceOrder({
  required BuildContext context,
  required String userOperationNumber,
  required int totalPrice,
  required User thisUser,
}) async {
  final PermissionStatus status = await Permission.sms.request();
  if (status.isGranted) {
    try {
      final _cartItem =
          Provider.of<CartProvider>(context, listen: false).iceCreams;

      final messages = await SmsQuery().querySms(
        kinds: [
          SmsQueryKind.inbox,
        ],
      );

      for (final message in messages) {
        if (message.address == "Syriatel") {
          if (message.body!.contains('تم تحويل مبلغ') &&
              message.body!.contains('ل.س من رقمك إلى صاحب الرقم/ الرمز') &&
              message.body!.contains('بنجاح وخصم') &
                  message.body!.contains('أجور التحويل. رقم العملية هو ')) {
            final amount = extractAmount(message.body as String);
            final operationNumber =
                extractOperationNumber(message.body as String);
            final phoneNumber = extractPhoneNumber(message.body as String);
//check if the message exists

            if (amount != null &&
                operationNumber != null &&
                phoneNumber != null &&
                phoneNumber == thisPhoneNumber &&
                userOperationNumber == operationNumber && //
                //  int.parse(amount) >= totalPrice
                100000 >= totalPrice) {
              //now check from server
              final thisFlag = await checkOrderOperationNumber(
                userOperationNumber,
                thisUser.email,
              );
              if (thisFlag == true) {
                return errorOperationNumber(
                  context: context,
                  thisTitle:
                      AppLocalizations.of(context)!.operation_already_exists,
                  thisSubtitle:
                      AppLocalizations.of(context)!.please_make_a_transfer,
                );
              } else {
                placeAnOrder(
                  context: context,
                  user: thisUser,
                  cartItem: _cartItem,
                  operationNumber: userOperationNumber,
                  totalPrice: int.parse(amount),
                );
                return;
              }
            }
          }
        }
      }
    } catch (e) {
      showError(context, AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.try_again);
      return;
    }
  } else {
    showError(context, AppLocalizations.of(context)!.permission_denied,
        AppLocalizations.of(context)!.try_again);
  }
}

Future<void> placeAnOrder({
  required BuildContext context,
  required User user,
  required List<CartModel> cartItem,
  required String operationNumber,
  required int totalPrice,
}) async {
  String thisdetails = '';
  for (int i = 0; i < cartItem.length; i++) {
    thisdetails +=
        '${cartItem[i].title} ${cartItem[i].details} ${cartItem[i].count.toString()} ,\n';
  }
  var body = json.encode({
    "phoneNumber": user.phoneNumber.toString(),
    "location": user.location.toString(),
    "username": user.userName.toString(),
    "email": user.email.toString(),
    "totalPrice": totalPrice,
    "details": thisdetails,
    "delivered": "No",
    "operationNumber": operationNumber,
  });
  final response = await http.post(
    Uri.parse('${url}createOrder/'),
    body: body,
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    await checkPointsSystem(totalPrice, int.parse(user.totalPurchases),
        int.parse(user.points), context);
    showSuccess(context, AppLocalizations.of(context)!.all_done,
        AppLocalizations.of(context)!.order_placed_success);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  } else {
    showError(context, AppLocalizations.of(context)!.error,
        '${response.reasonPhrase}');
  }
}

String? extractAmount(String message) {
  final amountMatch =
      RegExp(r'تم تحويل مبلغ (\d+) ل.س من رقمك إلى صاحب الرقم/ الرمز')
          .firstMatch(message);
  if (amountMatch != null) {
    return amountMatch.group(1);
  } else {
    return null;
  }
}

String? extractOperationNumber(String message) {
  final operationNumberMatch =
      RegExp(r'رقم العملية هو (\d+)').firstMatch(message);
  if (operationNumberMatch != null) {
    return operationNumberMatch.group(1);
  } else {
    return null;
  }
}

String? extractPhoneNumber(String message) {
  final phoneNumberMatch =
      RegExp(r' صاحب الرقم/ الرمز (\d+) بنجاح وخصم').firstMatch(message);
  if (phoneNumberMatch != null) {
    return phoneNumberMatch.group(1);
  } else {
    return null;
  }
}

Future<bool> checkOrderOperationNumber(
  String operationNum,
  String? email,
) async {
  var flag = false;
  final response = await http.get(Uri.parse('${url}getOrderByEmail/$email'));

  if (response.statusCode == 200) {
    final selectedData = json.decode(response.body) as List;
    for (int i = 0; i < selectedData.length; i++) {
      if (selectedData[i]['operationNumber'] == operationNum) {
        flag = true;
        return flag;
      }
    }
    return flag;
  }
  return flag;
}

Future<void> checkPointsSystem(int totalPrice, int userPurchase,
    int userDiscount, BuildContext context) async {
  int sumOfPurchase = totalPrice + userPurchase;
  if (sumOfPurchase >= 50000) {
    int discountAmount = 0;
    while (sumOfPurchase >= 50000) {
      discountAmount += 5000;
      sumOfPurchase -= 50000;
    }
    int total_discount = discountAmount + userDiscount;

    await Provider.of<UserProvider>(context, listen: false)
        .updatePurchase(sumOfPurchase, context);
    await Provider.of<UserProvider>(context, listen: false)
        .updatePoints(total_discount, context);
    //send details
  } else {
    int thisDiscount = userDiscount;
    await Provider.of<UserProvider>(context, listen: false)
        .updatePurchase(sumOfPurchase, context);
    await Provider.of<UserProvider>(context, listen: false)
        .updatePoints(thisDiscount, context);
  }
}

Future<void> placeFreeOrder(
    {required int newPoints,
    required BuildContext context,
    required purchases}) async {
  await Provider.of<UserProvider>(context, listen: false)
      .updatePoints(newPoints, context);
  String newOperationNumber = generateRandomNumber();
  final secureStorage = SecureStorageService();
  var thisEmail = await secureStorage.getEmail();
  bool freeOrderExsits =
      await checkOrderOperationNumber(newOperationNumber, thisEmail);
  if (freeOrderExsits == true) {
    final cartItem =
        Provider.of<CartProvider>(context, listen: false).iceCreams;
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    String thisdetails = '';
    for (int i = 0; i < cartItem.length; i++) {
      thisdetails +=
          '${cartItem[i].title} ${cartItem[i].details} ${cartItem[i].count.toString()} ,\n';
    }
    var body = json.encode({
      "phoneNumber": user.phoneNumber.toString(),
      "location": user.location.toString(),
      "username": user.userName.toString(),
      "email": user.email.toString(),
      "totalPrice": purchases,
      "details": thisdetails,
      "delivered": "No",
      "operationNumber": newOperationNumber,
    });
    final response = await http.post(
      Uri.parse('${url}createOrder/'),
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      showSuccess(context, AppLocalizations.of(context)!.all_done,
          AppLocalizations.of(context)!.order_placed_success);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      showError(context, AppLocalizations.of(context)!.error,
          '${response.reasonPhrase}');
    }
  } else {
    showError(context, AppLocalizations.of(context)!.error,
        '${AppLocalizations.of(context)!.operation_already_exists}');
  }
}

String generateRandomNumber() {
  String answer = '';
  Random a = Random();
  for (int i = 0; i < 12; i++) {
    answer += a.nextInt(1).toString();
  }
  print(answer);
  return answer;
}
