import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';

class CartDetailsHelper extends StatefulWidget {
  const CartDetailsHelper({
    super.key,
    required this.icecream,
  });
  final CartModel icecream;

  @override
  State<CartDetailsHelper> createState() => _CartDetailsHelperState();
}

class _CartDetailsHelperState extends State<CartDetailsHelper> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(widget.icecream.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.icecream.title,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.icecream.details,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.icecream.price.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 5, 173, 11),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .updateSum(
                        widget.icecream.price,
                      );
                      setState(() {
                        widget.icecream.count++;
                      });
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  Text(
                    widget.icecream.count.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.icecream.count > 1) {
                        Provider.of<CartProvider>(context, listen: false)
                            .updateSum(
                          -widget.icecream.price,
                        );
                        setState(() {
                          widget.icecream.count--;
                        });
                      } else {
                        swipeToDeleteMessage(
                          context: context,
                          thisSubtitle:
                              AppLocalizations.of(context)!.swipe_from_right,
                          thisTitle:
                              AppLocalizations.of(context)!.counter_must_be,
                        );
                      }
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
