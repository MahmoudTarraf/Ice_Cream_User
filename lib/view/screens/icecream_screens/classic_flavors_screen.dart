import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../helper/helpers.dart';
import '../screens.dart';

class ClassicFlavorsScreen extends StatelessWidget {
  const ClassicFlavorsScreen({super.key});
  static const routeName = '/classic_flavors_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.pink,
        onRefresh: () async {
          Provider.of<OtherStuffProvider>(context, listen: false).resetLists();

          final IceCreamProvider getIceCreamVar = IceCreamProvider();
          await getIceCreamVar.getIceCreams(context: context);
        },
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              SpecialAppBarHelper(
                anotherFlag: false,
                name: AppLocalizations.of(context)!.classic_screen_header,
                flag: true,
                val: 25,
              ),
              const SizedBox(
                height: 40,
              ),
              const IconCreator(),
              const SizeCreatorHelper(),
              const SizedBox(
                height: 60,
              ),
              FlavorCreatorScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
