import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/providers/providers.dart';

class SizeCreatorHelper extends StatefulWidget {
  const SizeCreatorHelper({super.key});

  @override
  State<SizeCreatorHelper> createState() => _SizeCreatorHelperState();
}

class _SizeCreatorHelperState extends State<SizeCreatorHelper> {
  var selected = 1;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<ClassicProvider>(context, listen: false)
                  .setSizeTitle('Small');
              setState(() {
                selected = 1;
              });
            },
            child: Text(
              AppLocalizations.of(context)!.small_size,
              style: TextStyle(
                fontFamily: 'bonbon',
                fontWeight: FontWeight.bold,
                color: selected == 1 ? Colors.pink : Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<ClassicProvider>(context, listen: false)
                  .setSizeTitle('Medium');
              setState(() {
                selected = 2;
              });
            },
            child: Text(
              AppLocalizations.of(context)!.medium_size,
              style: TextStyle(
                color: selected == 2 ? Colors.pink : Colors.black,
                fontSize: 24,
                fontFamily: 'bonbon',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<ClassicProvider>(context, listen: false)
                  .setSizeTitle('Large');
              setState(() {
                selected = 3;
              });
            },
            child: Text(
              AppLocalizations.of(context)!.large_size,
              style: TextStyle(
                fontFamily: 'bonbon',
                fontWeight: FontWeight.bold,
                color: selected == 3 ? Colors.pink : Colors.black,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
