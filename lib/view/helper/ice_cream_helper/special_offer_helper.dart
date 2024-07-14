import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../model/models.dart';
import '../../screens/screens.dart';

class SpecialOfferHelper extends StatefulWidget {
  final List<SpecialOffer>
      offers; // List of special offers (image URLs and details)
  final Duration rotationDuration; // Duration between image rotations

  const SpecialOfferHelper({
    super.key,
    required this.offers,
    this.rotationDuration = const Duration(seconds: 3),
  });

  @override
  State<SpecialOfferHelper> createState() => _SpecialOfferHelperState();
}

class _SpecialOfferHelperState extends State<SpecialOfferHelper> {
  int _currentIndex = 0; // Current image index
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // Schedule timer to change image periodically
    _timer = Timer.periodic(
      widget.rotationDuration,
      (_) => setState(
          () => _currentIndex = (_currentIndex + 1) % widget.offers.length),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentOffer = widget.offers[_currentIndex];
    final IceCream temp = IceCream(
      category: currentOffer.category,
      details: currentOffer.details,
      image: currentOffer.image,
      title: currentOffer.title,
      price: currentOffer.newPrice,
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        // Use Stack to position text on top of the image
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IceCreamDetails(
                    iceCream: temp,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.memory(
                base64Decode(
                  currentOffer.image,
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          ),
          Positioned(
            // Position text at desired location
            bottom: 5.0, // Adjust for padding
            left: 100.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 120,
                  // ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          currentOffer
                              .title, // Assuming price is a property in SpecialOffer
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Positioned(
            // Position text at desired location
            // Adjust for padding
            left: 20,
            top: 100,
            child: Column(children: [
              Text(
                '${currentOffer.oldPrice}', // Assuming price is a property in SpecialOffer
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  shadows: [
                    // Add shadow for better readability on image
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              Text(
                '${currentOffer.newPrice}', // Assuming price is a property in SpecialOffer
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  shadows: [
                    // Add shadow for better readability on image
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
