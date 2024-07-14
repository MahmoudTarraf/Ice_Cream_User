import 'package:flutter/material.dart';

import '../../helper/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointsInfoScreen extends StatelessWidget {
  const PointsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpecialAppBarHelper(
                name: AppLocalizations.of(context)!.points_system,
                flag: false,
                val: 25,
                anotherFlag: false,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "For every Purchase Process you make, The amount of your purchases gets added to the previous ones until you reach the amount: 50000.\n\nThen 5000 gets added to your points.\nYou can use your points when you make a new purchase as it will be discounted from the total amount of your purchases.\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
