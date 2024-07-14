// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/change_user_settings/change_user_settings.dart';
import '../../../controller/providers/providers.dart';
import '../../screens/screens.dart';
import '../helpers.dart';

class ProfileSettings extends StatefulWidget {
  static const routeName = '/Profile_settings';
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  var thisIndex = 0;
  String _newUserName = '';
  String _newEmail = '';
  String _newPhoneNumber = '';
  void changeUserName(String val) {
    _newUserName = val;
  }

  void changeEmail(String val) {
    _newEmail = val;
  }

  void changePhoneNumber(String val) {
    _newPhoneNumber = val;
  }

  void changeLocation() async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result == true) {
    //   print('YAY! Free cute dog pics!');
    // } else {
    //   print('No internet :( Reason:');
    //   print(InternetConnectionChecker().connectionStatus);
    //   Restart.restartApp();
    // }
  }

  bool getCondition() {
    if (thisIndex <= 3 && thisIndex >= 1) {
      return true;
    }
    return false;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _validateThis(
      {required int index,
      required BuildContext context,
      required String q}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    var name = '';
    switch (index) {
      case 1:
        name = AppLocalizations.of(context)!.username;
      case 2:
        name = AppLocalizations.of(context)!.email_profile;
      case 3:
        name = AppLocalizations.of(context)!.phoneNumber_profile;

      default:
        name = "";
    }
    var a = AppLocalizations.of(context)!.change;
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '$a $name $q',
          style: const TextStyle(
            color: Colors.pink,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              a,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
    if (isConfirmed != false) {
      if (index == 1) {
        Provider.of<UserProvider>(context, listen: false)
            .changeUserName(_newUserName, context)
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage2(),
                ),
              ),
            );
      } else if (index == 2) {
        Provider.of<UserProvider>(context, listen: false)
            .changethatEmail(_newEmail, context)
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage2(),
                ),
              ),
            );
      } else if (index == 3) {
        Provider.of<UserProvider>(context, listen: false)
            .changePhonethatNumber(_newPhoneNumber, context)
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage2(),
                ),
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final thisUser = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUser;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SpecialAppBarHelper(
                    anotherFlag: false,
                    name: AppLocalizations.of(context)!.change_profile,
                    flag: false,
                    val: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thisIndex = 1;
                      });
                    },
                    child: itemCreatot(
                      title: AppLocalizations.of(context)!.change_username,
                      subTitle: thisUser.userName,
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ),
                  Visibility(
                    visible: thisIndex == 1 ? true : false,
                    child: ChangeUserName(
                      changeuserNameHandler: changeUserName,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thisIndex = 2;
                      });
                    },
                    child: itemCreatot(
                      title: AppLocalizations.of(context)!.change_email,
                      subTitle: thisUser.email.toString(),
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ),
                  Visibility(
                    visible: thisIndex == 2 ? true : false,
                    child: ChangeEmail(
                      changeemailHandler: changeEmail,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thisIndex = 3;
                      });
                    },
                    child: itemCreatot(
                      title: AppLocalizations.of(context)!.change_phonenumber,
                      subTitle: thisUser.phoneNumber,
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ),
                  Visibility(
                    visible: thisIndex == 3 ? true : false,
                    child: ChangePhoneNumber(
                      changePhoneHandler: changePhoneNumber,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: itemCreatot(
                      title: AppLocalizations.of(context)!.change_location,
                      subTitle: thisUser.location,
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ),
                  Visibility(
                    visible: getCondition(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.save_button,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          final local = Provider.of<LocaleProvider>(context,
                                  listen: false)
                              .currentLocale;
                          String q = local == const Locale('en') ? '?' : '؟';
                          _validateThis(
                            index: thisIndex,
                            context: context,
                            q: q,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemCreatot({
  required String title,
  required String subTitle,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
    child: ListTile(
      title: Text(
        title,
      ),
      subtitle: Text(
        subTitle,
      ),
      trailing: Icon(
        icon,
        color: Colors.grey.shade400,
      ),
    ),
  );
}
