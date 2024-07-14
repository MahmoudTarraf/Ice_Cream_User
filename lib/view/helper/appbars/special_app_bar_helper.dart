// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../../screens/profile_screens/points_info_screen.dart';
import '../../screens/screens.dart';

class SpecialAppBarHelper extends StatelessWidget {
  SpecialAppBarHelper({
    super.key,
    required this.name,
    required this.flag,
    required this.val,
    required this.anotherFlag,
  });
  double? val;
  String name;
  bool flag;
  bool anotherFlag;
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context).currentLocale;
    Color lightColor = const Color.fromARGB(255, 253, 222, 231);
    Color darkColor = const Color.fromARGB(255, 219, 120, 148);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    textDirection: TextDirection.ltr,
                    Icons.arrow_back_ios,
                    size: 20,
                    color: darkColor,
                  ),
                ),
              ),
            ),
            Text(
              textDirection: localeProvider == const Locale('en')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              name,
              style: TextStyle(
                fontSize: val,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              ),
            ),
            flag == true
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IceCreamCart(),
                          ));
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
                          Icons.shopping_cart,
                          size: 25,
                          color: darkColor,
                        ),
                      ),
                    ),
                  )
                : Container(),
            anotherFlag == true
                ? GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PointsInfoScreen(),
                        )),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: darkColor,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
