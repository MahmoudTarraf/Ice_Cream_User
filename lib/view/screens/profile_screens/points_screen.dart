import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../helper/helpers.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final thisUser = Provider.of<UserProvider>(context, listen: true).getUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SpecialAppBarHelper(
            name: AppLocalizations.of(context)!.your_points,
            flag: false,
            val: 25,
            anotherFlag: true,
          ),
          SizedBox(
            height: 50,
          ),
          PurchaseAmount(purchaseAmount: thisUser.totalPurchases),
          MyPoints(myPoints: thisUser.points),
        ]),
      ),
    );
  }
}

class PurchaseAmount extends StatelessWidget {
  final String purchaseAmount;

  const PurchaseAmount({required this.purchaseAmount});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            AppLocalizations.of(context)!.purchase_amount2,
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: purchaseAmount,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " / ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "50000",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPoints extends StatelessWidget {
  const MyPoints({super.key, required this.myPoints});
  final String myPoints;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            AppLocalizations.of(context)!.earned_points,
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            "$myPoints ${AppLocalizations.of(context)!.sp}",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
