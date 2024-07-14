// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';

class CartTotalHelper extends StatelessWidget {
  const CartTotalHelper({super.key});

  get secureStorage => null;

  int getPrice(int totalValue, int points) {
    var answer = 0;
    if (totalValue >= points) {
      answer = totalValue - points;
      // send http to change points
    } else {
      answer = 0;
    }
    return answer;
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;
    final totalPrice = Provider.of<CartProvider>(context).getTotalPrice;
    final thisUser = Provider.of<UserProvider>(context, listen: true).getUser;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                textDirection: localProvider == const Locale('en')
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    AppLocalizations.of(context)!.purchase_amount1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    '$totalPrice',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                textDirection: localProvider == const Locale('en')
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    AppLocalizations.of(context)!.points_discount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${thisUser.points}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                textDirection: localProvider == const Locale('en')
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    AppLocalizations.of(context)!.total_cost,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${getPrice(totalPrice, int.parse(thisUser.points))}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (totalPrice == 0) {
                      errorOperationNumber(
                        context: context,
                        thisSubtitle:
                            AppLocalizations.of(context)!.add_some_items,
                        thisTitle: AppLocalizations.of(context)!.cart_empty,
                      );
                    } else {
                      int newPoints = int.parse(thisUser.points) - totalPrice;
                      int newPurchase = totalPrice - int.parse(thisUser.points);
                      await placeFreeOrder(
                          newPoints: newPoints,
                          context: context,
                          purchases: newPurchase);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.checkout_button,
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
