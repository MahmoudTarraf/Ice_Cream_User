// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../../model/models.dart';

class OrdersHelper extends StatefulWidget {
  OrdersHelper({
    super.key,
    required this.orders,
    required this.condition,
  });
  List<OrderModel> orders;
  bool condition;

  @override
  State<OrdersHelper> createState() => _OrdersHelperState();
}

class _OrdersHelperState extends State<OrdersHelper> {
  String getName(String status) {
    if (status == "Yes") {
      return "Success";
    } else if (status == "No") {
      return "Not Delivered";
    } else if (status == "Pending") {
      return "Pending";
    } else {
      return "";
    }
  }

  getColor(String status) {
    if (status == "Yes") {
      return Colors.green;
    } else if (status == "No") {
      return Colors.red;
    } else if (status == "Pending") {
      return Colors.amber;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;
    return Directionality(
      textDirection: localProvider == const Locale('en')
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: ListView.builder(
        itemBuilder: (context, index) {
          var thisOrder = widget.orders[index];

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: const Offset(2.0, 4.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to left
                children: [
                  itemCreator(
                    AppLocalizations.of(context)!.operation_number,
                    thisOrder.operationNumber,
                    Colors.pink,
                    true,
                  ),
                  itemCreator(
                    AppLocalizations.of(context)!.username,
                    thisOrder.userName,
                    Colors.black,
                    false,
                  ),
                  itemCreator(
                    AppLocalizations.of(context)!.email_profile,
                    thisOrder.email,
                    Colors.black,
                    false,
                  ),
                  itemCreator(
                    AppLocalizations.of(context)!.phoneNumber_profile,
                    thisOrder.phoneNumber,
                    Colors.black,
                    false,
                  ),
                  itemCreator(
                    AppLocalizations.of(context)!.location_profile,
                    thisOrder.location,
                    Colors.black,
                    false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.details,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      thisOrder.details,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: itemCreator(
                      AppLocalizations.of(context)!.status,
                      getName(
                        thisOrder.delivered,
                      ),
                      getColor(
                        thisOrder.delivered,
                      ),
                      true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.orders.length,
      ),
    );
  }
}

Widget itemCreator(String title, var value, var color, var condition) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: condition ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
