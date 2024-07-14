import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartAppBarHelper extends StatelessWidget {
  const CartAppBarHelper({super.key});

  @override
  Widget build(BuildContext context) {
    Color lightColor = const Color.fromARGB(255, 253, 222, 231);
    Color darkColor = const Color.fromARGB(255, 219, 120, 148);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: darkColor,
                ),
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.cart_screen_header,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}
