import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getCheckoutMessage(int totalAmount, BuildContext context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: AppLocalizations.of(context)!.checkout_using_syriatel_cash,
          style: const TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.you_need_syriatel_account,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.open_syriatel_app,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.app_name,
          style: const TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.choose_manual_trnasfer,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.enter,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' 0939672432',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.as,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' GSM/Code\n\n',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.re_enter,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' 0939672432',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.as,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' GSM/Code\n\n',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.enter_amount,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: ' $totalAmount\n\n',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.re_enter_amount,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: ' $totalAmount\n\n',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.press,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.check_transfer,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TextSpan(
          text: '           ---------------------',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.or,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TextSpan(
          text: ' ---------------------\n\n',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.on_your_phone_order,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' *3040#\n\n',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.enter,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const TextSpan(
          text: ' *',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.then,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.manual_transfer,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: AppLocalizations.of(context)!.same_process,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
