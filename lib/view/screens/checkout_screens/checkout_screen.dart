// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/Auth/auth.dart';
import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';
import '../../helper/helpers.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    super.key,
    required this.totalPrice,
  });
  int totalPrice;
  static const routeName = '/checkout_screen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var condition = false;
  Future<void> _validateThis(
      String operationNumber, int totalPrice, User thisUser) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    checkOrderConfirmationAndPlaceOrder(
      userOperationNumber: _operationNumber,
      totalPrice: totalPrice,
      context: context,
      thisUser: thisUser,
    );
  }

  String _operationNumber = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void setOperationNumber(String temp) {
    _operationNumber = temp;
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;
    int _totalPrice =
        Provider.of<CartProvider>(context, listen: false).getTotalPrice;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: localProvider == const Locale('en')
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpecialAppBarHelper(
                    anotherFlag: false,
                    name: AppLocalizations.of(context)!.checkout_button,
                    flag: false,
                    val: 25,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            condition = !condition;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            condition == true
                                ? AppLocalizations.of(context)!
                                    .hide_instructions
                                : AppLocalizations.of(context)!
                                    .show_instructions,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: condition,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: getCheckoutMessage(
                        widget.totalPrice.ceil(),
                        context,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 15,
                      right: 20,
                    ),
                    child: Text(
                      textDirection: localProvider == const Locale('en')
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      AppLocalizations.of(context)!.enter_operation_number,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 20,
                      right: 20,
                    ),
                    child: Text(
                      textDirection: localProvider == const Locale('en')
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      AppLocalizations.of(context)!.you_will_get_sms,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Center(
                    child: OperationNumber(
                      operationNumberHandler: setOperationNumber,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      // width: 240,
                      // height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.verify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          final temp =
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser;
                          _validateThis(
                            _operationNumber,
                            _totalPrice,
                            temp,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
