import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../helper/helpers.dart';

// ignore: must_be_immutable
class IceCreamCart extends StatelessWidget {
  IceCreamCart({super.key});

  Color lightColor = const Color.fromARGB(255, 253, 222, 231);
  Color darkColor = const Color.fromARGB(255, 219, 120, 148);

  @override
  Widget build(BuildContext context) {
    var iceCreamList =
        Provider.of<CartProvider>(context, listen: false).iceCreams;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CartAppBarHelper(),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 440,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var thisIcecream = iceCreamList[index];
                        return Dismissible(
                          onDismissed: (direction) {
                            Provider.of<CartProvider>(context, listen: false)
                                .deleteCartItem(
                              thisIcecream.title,
                              thisIcecream.count,
                            );
                          },
                          direction: DismissDirection.endToStart,
                          key: ValueKey(thisIcecream),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                            child: const Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          child: CartDetailsHelper(
                            icecream: thisIcecream,
                          ),
                        );
                      },
                      itemCount: iceCreamList.length,
                    ),
                  ),
                ],
              ),
            ),
            const CartTotalHelper(),
          ],
        ),
      ),
    );
  }
}
