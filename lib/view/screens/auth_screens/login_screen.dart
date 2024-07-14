// ignore_for_file: unused_field, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/Auth/auth.dart';
import '../../../controller/providers/providers.dart';
import '../screens.dart';

// ignore: must_be_immutable
class LogInScreen extends StatefulWidget {
  static const routeName = '/LogInScreen';

  const LogInScreen({super.key});
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool? rememberMe = false;

  String _userName = '';
  String _passWordLogin = '';

  void setUserName(String username) {
    _userName = username;
  }

  void setpasswordLogin(String password1) {
    _passWordLogin = password1;
  }

  final String backImg = 'assets/images/chocolate.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var condition = false;
  Future<void> _validateThis(bool? condition) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await Provider.of<Validator>(context, listen: false).login(
      condition: condition,
      context: context,
      password: _passWordLogin,
      userName: _userName,
    );
  }

  //

  @override
  Widget build(BuildContext context) {
    final local = Provider.of<LocaleProvider>(context).currentLocale;
    return ChangeNotifierProvider<LocaleProvider>(
      create: (context) => LocaleProvider(),
      child: Directionality(
        textDirection:
            local == const Locale('en') ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backImg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.black54,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(height: kToolbarHeight + 40),
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.welcome,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30.0,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                AppLocalizations.of(context)!.login_msg,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Column(
                            children: [
                              UserName(
                                userNameHandler: setUserName,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Password(passwordHandler: setpasswordLogin),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.pink,
                                      fillColor: const MaterialStatePropertyAll(
                                          Colors.white),
                                      value: rememberMe,
                                      onChanged: (val) {
                                        setState(() {
                                          rememberMe = val;
                                        });
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.remember_me,
                                      style: const TextStyle(
                                        color: Colors.pink,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: <Widget>[
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.pink,
                                    onPrimary: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      condition = true;
                                    });
                                    _validateThis(rememberMe).then((value) {
                                      setState(() {
                                        condition = false;
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: condition == true
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!.login,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey.shade700,
                                    onPrimary: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      AppLocalizations.of(context)!.signup,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                          const SizedBox(height: 70.0),
                        ],
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
