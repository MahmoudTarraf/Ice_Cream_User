import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../screens/screens.dart';

// ignore: must_be_immutable
class AppBarHelper extends StatefulWidget {
  const AppBarHelper({super.key});

  @override
  State<AppBarHelper> createState() => _AppBarHelperState();
}

class _AppBarHelperState extends State<AppBarHelper> {
  var condition = false;
  Color lightColor = const Color.fromARGB(255, 253, 222, 231);

  Color darkColor = const Color.fromARGB(255, 219, 120, 148);

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage2(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.menu,
                  color: darkColor,
                ),
              ),
            ),
            Text(
              textDirection: localProvider == const Locale('en')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              AppLocalizations.of(context)!.explore_flavors,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.pink,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
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
            ),
            condition == true
                ? const CircularProgressIndicator(
                    color: Colors.pink,
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        condition = true;
                      });
                      Provider.of<OtherStuffProvider>(context, listen: false)
                          .setOfferCondition(true);
                      Provider.of<OtherStuffProvider>(context, listen: false)
                          .setIceCreamsCondition(true);
                      Provider.of<OtherStuffProvider>(context, listen: false)
                          .resetLists();

                      final IceCreamProvider getIceCreamVar =
                          IceCreamProvider();
                      await getIceCreamVar.getIceCreams(context: context).then(
                            (value) => setState(() {
                              condition = false;
                            }),
                          );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.refresh,
                        color: darkColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
