import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../model/models.dart';
import '../screens.dart';
// ignore: must_be_immutable

class CategoryCreatorScreen extends StatelessWidget {
  final List<IceCream> categoryList;
  const CategoryCreatorScreen({
    super.key,
    required this.categoryList,
  });

  static const routeName = '/cat_screen';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 280,
        // color: Colors.yellow,
        margin: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            final thisCategory = categoryList[index];
            return GestureDetector(
              onTap: () {
                if (thisCategory.title == 'Special Desserts') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SpecialDessertsScreen(),
                    ),
                  );
                } else if (thisCategory.title == 'Classic Flavors') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClassicFlavorsScreen(),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(
                    right: 20), // Add spacing between images
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.memory(
                        base64Decode(categoryList[index].image),
                        height: 230,
                      ),
                    ),
                    Positioned(
                      bottom: 55.0, // Position text at bottom of image
                      left: 40.0, // Adjust for padding
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            categoryList[index].title,
                            style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
