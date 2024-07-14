// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:graduation_project/controller/providers/providers.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens.dart';

class IntroViewsPage extends StatelessWidget {
  static const routeName = '/IntroViewsPage';

  final pages = [
    PageViewModel(
        pageColor: const Color.fromARGB(255, 221, 136, 9),
        bubble: Image.asset('assets/images/classic2.jpeg'),
        body: Builder(builder: (context) {
          final local = Provider.of<LocaleProvider>(context).currentLocale;
          return Text(
            textDirection: local == const Locale('en')
                ? TextDirection.ltr
                : TextDirection.rtl,
            AppLocalizations.of(context)!.delicious_flavors,
          );
        }),
        title: const Text(
          'Scoobs & Delights',
          style: TextStyle(fontSize: 40, fontFamily: 'bonbon'),
        ),
        titleTextStyle: const TextStyle(color: Colors.white),
        bodyTextStyle: const TextStyle(color: Colors.white),

        /// -----------------------------------------------
        /// Main image.
        /// -----------------------------------------------
        mainImage: Image.asset(
          'assets/images/classic2.jpeg',
          // height: 285.0,
          // width: 285.0,
          // alignment: Alignment.center,
          fit: BoxFit.cover,
        )),
    PageViewModel(
      pageColor: const Color.fromARGB(255, 219, 120, 148),
      iconImageAssetPath: 'assets/images/strawberry.png',
      body: Builder(builder: (context) {
        final local = Provider.of<LocaleProvider>(context).currentLocale;
        return Text(
          textDirection: local == const Locale('en')
              ? TextDirection.ltr
              : TextDirection.rtl,
          AppLocalizations.of(context)!.we_have,
        );
      }),
      title: const Text(
        'Scoobs & Delights',
        style: TextStyle(fontSize: 40, fontFamily: 'bonbon'),
      ),
      mainImage: Image.asset(
        'assets/images/strawberry.png',
        height: 285.0,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      bodyTextStyle: const TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Colors.brown,
      iconImageAssetPath: 'assets/images/chocolate.png',
      body: Builder(builder: (context) {
        final local = Provider.of<LocaleProvider>(context).currentLocale;
        return Text(
          textDirection: local == const Locale('en')
              ? TextDirection.ltr
              : TextDirection.rtl,
          AppLocalizations.of(context)!.log_or_sig,
        );
      }),
      title: const Text(
        'Scoobs & Delights',
        style: TextStyle(fontSize: 40, fontFamily: 'bonbon'),
      ),
      mainImage: Image.asset(
        'assets/images/chocolate.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      bodyTextStyle: const TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
      create: (context) => LocaleProvider(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: IntroViewsFlutter(
          backText: Text(
            AppLocalizations.of(context)!.back_text,
          ),
          nextText: Text(
            AppLocalizations.of(context)!.next_text,
          ),
          skipText: Text(
            AppLocalizations.of(context)!.skip_text,
          ),
          doneText: Text(
            AppLocalizations.of(context)!.done_text,
          ),
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<LocaleProvider>(
                  create: (context) => LocaleProvider(),
                  child: const SignUpScreen(),
                ), //MaterialPageRoute
              ),
            );
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
