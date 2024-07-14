// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../../controller/syriatel_cash/syriatel.dart';
import '../../../model/models.dart';

class IceCreamDetails extends StatefulWidget {
  final IceCream iceCream;
  const IceCreamDetails({super.key, required this.iceCream});
  static const routeName = '/ice_cream_details';

  @override
  State<IceCreamDetails> createState() => _IceCreamDetailsState();
}

class _IceCreamDetailsState extends State<IceCreamDetails> {
  var thisCounter = 1;
  var lightColor = const Color.fromARGB(255, 255, 217, 227);

  var darkColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: lightColor,
                      child: Image.memory(
                        base64Decode(widget.iceCream.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          padding: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: lightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // to hereeeeeeeeeeeeeeeeeeeeeeeeee

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.iceCream.title,
                            style: TextStyle(
                              color: darkColor,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${widget.iceCream.price}",
                                style: TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 108,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: darkColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      thisCounter++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              thisCounter.toString(),
                              style: TextStyle(
                                color: darkColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                thisCounter > 0
                                    ? setState(() {
                                        thisCounter--;
                                      })
                                    : thisCounter = 0;
                              },
                              child: Container(
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: lightColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: darkColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.iceCream.details,
                        softWrap: true,
                        style: TextStyle(
                          color: darkColor.withOpacity(0.5),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 240,
                        child: ElevatedButton(
                          onPressed: () {
                            String temp = Provider.of<ClassicProvider>(
                              context,
                              listen: false,
                            ).getClassicDetails;
                            if (temp == ',') {
                              temp = 'Cones, Small';
                            }
                            final thisDetails =
                                widget.iceCream.category == 'Classic Flavors'
                                    ? temp
                                    : 'Special Dessert';
                            if (thisCounter > 0) {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addCartItem(
                                count: thisCounter,
                                image: widget.iceCream.image,
                                price: widget.iceCream.price,
                                title: widget.iceCream.title,
                                details: thisDetails,
                              );
                              addToCartMessage(context, widget.iceCream.title);
                            } else {
                              cartErrorCountMessage(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: darkColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.add_to_cart,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
