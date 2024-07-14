import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';

class IconCreator extends StatefulWidget {
  const IconCreator({super.key});

  @override
  State<IconCreator> createState() => _IconCreatorState();
}

class _IconCreatorState extends State<IconCreator> {
  var selected = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 150,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<ClassicProvider>(context, listen: false)
                      .setIconTitle('Cones');
                  setState(() {
                    selected = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/cones.png',
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Cones',
                        style: TextStyle(
                          color: selected == 1 ? Colors.pink : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ClassicProvider>(context, listen: false)
                      .setIconTitle('Bars');
                  setState(() {
                    selected = 2;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bars.jpeg',
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Bars',
                        style: TextStyle(
                          color: selected == 2 ? Colors.pink : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ClassicProvider>(context, listen: false)
                      .setIconTitle('Cups');
                  setState(() {
                    selected = 3;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/cups.png',
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Cups',
                        style: TextStyle(
                          color: selected == 3 ? Colors.pink : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ClassicProvider>(context, listen: false)
                      .setIconTitle('Bowls');
                  setState(() {
                    selected = 4;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bowls.png',
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Bowls',
                        style: TextStyle(
                          color: selected == 4 ? Colors.pink : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ClassicProvider>(context, listen: false)
                      .setIconTitle('Waffle Bowls');
                  setState(() {
                    selected = 5;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/waffle_bowls.png',
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Waffle Bowls',
                        style: TextStyle(
                          color: selected == 5 ? Colors.pink : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
