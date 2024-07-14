import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';
import '../screens.dart';

// ignore: must_be_immutable
class FlavorCreatorScreen extends StatelessWidget {
  FlavorCreatorScreen({super.key});
  var lightColor = const Color.fromARGB(255, 255, 217, 227);
  var darkColor = Colors.pink;
  @override
  Widget build(BuildContext context) {
    List<IceCream> iceCreams =
        Provider.of<OtherStuffProvider>(context).classicFlavorsList;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 280,
        // color: Colors.yellow,
        margin: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: iceCreams.length,
          itemBuilder: (context, index) {
            final iceCream = iceCreams[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IceCreamDetails(
                      iceCream: iceCream,
                    ),
                  ),
                );
              },
              child: Container(
                width: 250,
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        // color: Colors.yellow,
                        image: DecorationImage(
                          image: MemoryImage(
                            base64Decode(iceCream.image),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      iceCream.title,
                      style: TextStyle(
                        color: darkColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$${iceCream.price}",
                            style: TextStyle(
                              color: darkColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final String thisDetails =
                                  Provider.of<ClassicProvider>(context,
                                          listen: false)
                                      .getClassicDetails;
                              Provider.of<CartProvider>(context, listen: false)
                                  .addCartItem(
                                count: 1,
                                image: iceCream.image,
                                price: iceCream.price,
                                title: iceCream.title,
                                details: thisDetails,
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
