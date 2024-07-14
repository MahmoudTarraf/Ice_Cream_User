import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';

class SmallContainer extends StatelessWidget {
  final IceCream icecream;
  const SmallContainer({super.key, required this.icecream});

  @override
  Widget build(BuildContext context) {
    Color lightColor = const Color.fromARGB(255, 253, 222, 231);
    Color darkColor = const Color.fromARGB(255, 219, 120, 148);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: MemoryImage(
              base64Decode(
                icecream.image,
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(0),
              ],
              begin: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                icecream.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        icecream.price.toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 100, 150, 1),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addCartItem(
                            count: 1,
                            image: icecream.image,
                            price: icecream.price,
                            title: icecream.title,
                            details: 'Special Desserts',
                          );
                          addToCartMessage(context, icecream.title);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            color: lightColor,
                          ),
                        ),
                      ),
                    ],
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
