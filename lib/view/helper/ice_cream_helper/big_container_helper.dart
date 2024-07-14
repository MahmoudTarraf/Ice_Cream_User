import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';

class BigContainer extends StatelessWidget {
  final IceCream iceCream;
  const BigContainer({
    super.key,
    required this.iceCream,
  });
  @override
  Widget build(BuildContext context) {
    Color lightColor = const Color.fromARGB(255, 253, 222, 231);
    Color darkColor = const Color.fromARGB(255, 219, 120, 148);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AspectRatio(
        aspectRatio: 1.25 / 2,
        child: Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: MemoryImage(
                base64Decode(
                  iceCream.image,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.6),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  iceCream.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      iceCream.price.toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 100, 150, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addCartItem(
                          count: 1,
                          image: iceCream.image,
                          price: iceCream.price,
                          title: iceCream.title,
                          details: 'Special Desserts',
                        );
                        addToCartMessage(context, iceCream.title);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
