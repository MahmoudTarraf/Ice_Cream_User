import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Email extends StatelessWidget {
  final Function emailHandler;
  Email({super.key, required this.emailHandler});
  String _email = '';
  Widget _checkEmail(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email must\'nt be empty!';
            }
            if (!value.contains('@')) {
              return 'This is not a valid Email';
            }
            return null;
          },
          onSaved: (value) {
            _email = value as String;
            emailHandler(_email);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            hintText: AppLocalizations.of(context)!.email_profile,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkEmail(context);
  }
}
