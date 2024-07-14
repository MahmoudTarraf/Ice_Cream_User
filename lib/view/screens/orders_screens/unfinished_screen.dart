import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../helper/helpers.dart';

class UnFinishedScreen extends StatelessWidget {
  const UnFinishedScreen({super.key});
  static const routeName = '/unfinished_ooders';
  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;
    final theseOrders = Provider.of<OrderProvider>(context, listen: false)
        .getUnFinishedOrderList;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RefreshIndicator(
        color: Colors.pink,
        onRefresh: () async {
          await Provider.of<OrderProvider>(context, listen: false)
              .getOrderByEmail(context);
        },
        child: Scaffold(
          body: theseOrders.isEmpty
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          textDirection: localProvider == const Locale('en')
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          AppLocalizations.of(context)!.no_orders_text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : OrdersHelper(
                  orders: theseOrders,
                  condition: true,
                ),
        ),
      ),
    );
  }
}
