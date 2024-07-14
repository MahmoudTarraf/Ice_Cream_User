import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../helper/helpers.dart';

class SettingsPage2 extends StatefulWidget {
  static const routeName = '/SettingsPage2';
  const SettingsPage2({super.key});

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    await Provider.of<UserProvider>(context, listen: false).getUserDetails();
  }

  String selectedLanguage = 'en';
  void getValueForLanguage() {
    final local = Provider.of<LocaleProvider>(context).currentLocale;
    if (local == const Locale('en')) {
      setState(() {
        selectedLanguage = 'en';
      });
    } else {
      setState(() {
        selectedLanguage = 'ar';
      });
    }
  }

  String getLangName() {
    final localeProvider = Provider.of<LocaleProvider>(context);
    if (localeProvider.currentLocale == const Locale('en')) {
      return "English";
    } else {
      return "العربية";
    }
  }

  void _changeLanguage(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
    });
  }

  var condition = false;
  @override
  Widget build(BuildContext context) {
    final local = Provider.of<LocaleProvider>(context);
    getValueForLanguage();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              SpecialAppBarHelper(
                anotherFlag: false,
                name: AppLocalizations.of(context)!.profile,
                flag: false,
                val: 25,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    condition = !condition;
                  });
                },
                child: itemCreatot(
                  context: context,
                  title: AppLocalizations.of(context)!.language,
                  subTitle: getLangName(),
                  icon: Icons.keyboard_arrow_right,
                ),
              ),
              Visibility(
                visible: condition,
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('العربية'),
                      groupValue: selectedLanguage,
                      value: 'ar',
                      onChanged: (value) {
                        _changeLanguage(value!);
                        local.changeLocale(const Locale('ar'));
                      },
                      activeColor: Colors.pink, // Highlight selected language
                    ),
                    RadioListTile<String>(
                      title: const Text('English'),
                      groupValue: selectedLanguage,
                      value: 'en',
                      onChanged: (value) {
                        _changeLanguage(value!);
                        local.changeLocale(const Locale('en'));
                      },
                      activeColor: Colors.pink, // Highlight selected language
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSettings(),
                    ),
                  );
                },
                child: itemCreatot(
                  context: context,
                  title: AppLocalizations.of(context)!.change_profile,
                  subTitle: AppLocalizations.of(context)!.change_now,
                  icon: Icons.keyboard_arrow_right,
                ),
              ),
              SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.notifications,
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.on,
                ),
                value: true,
                onChanged: (val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemCreatot({
  required BuildContext context,
  required String title,
  required String subTitle,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
    child: ListTile(
      title: Text(
        textDirection: TextDirection.ltr,
        title,
      ),
      subtitle: Text(
        textDirection: TextDirection.ltr,
        subTitle,
      ),
      trailing: Icon(
        textDirection: TextDirection.ltr,
        icon,
        color: Colors.grey.shade400,
      ),
    ),
  );
}
