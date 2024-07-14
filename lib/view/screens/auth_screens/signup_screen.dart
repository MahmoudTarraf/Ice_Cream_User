// ignore_for_file: unused_field, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/Auth/auth.dart';
import '../../../controller/providers/providers.dart';
import '../screens.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';

  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var condition = false;
  String _userName = '';
  String _passWordSignup = '';
  String _email = '';
  String _phoneNumber = '';
  void setUserName(String username) {
    _userName = username;
  }

  void setPasswordSignup(String password2) {
    _passWordSignup = password2;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhoneNumber(String phonenumber) {
    _phoneNumber = phonenumber;
  }

  final String backImg = 'assets/images/strawberry.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _validateThat() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      condition = true;
    });
    await Provider.of<Validator>(context, listen: false)
        .signup(
      context: context,
      email: _email,
      password: _passWordSignup,
      phoneNumber: _phoneNumber,
      userName: _userName,
    )
        .then((value) {
      setState(() {
        condition = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        ),
      );
    });
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
                              AppLocalizations.of(context)!.sign_msg,
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
                              height: 10,
                            ),
                            Email(emailHandler: setEmail),
                            const SizedBox(
                              height: 10,
                            ),
                            PhoneNumber(phoneHandler: setPhoneNumber),
                            const SizedBox(
                              height: 10,
                            ),
                            ReEnterPassword(
                                setReEnterPasswordHandler2: setPasswordSignup),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: <Widget>[
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LogInScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
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
                                  primary: Colors.pink,
                                  onPrimary: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: condition == true
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!.signup,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    condition = true;
                                  });
                                  _validateThat().then((value) {
                                    setState(() {
                                      condition = false;
                                    });
                                  });
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
        )),
      ),
    );
  }
}
