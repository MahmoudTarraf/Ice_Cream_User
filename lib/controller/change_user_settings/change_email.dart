import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ChangeEmail extends StatelessWidget {
  final Function changeemailHandler;
  ChangeEmail({super.key, required this.changeemailHandler});
  String _changeemail = '';
  Widget _checkChangeEmail(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.7),
            border: Border.all(
              width: 5,
              color: Colors.pink,
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email must\'nt be empty!';
            }
            if (!value.contains('@')) {
              return 'This is not a valid ChangeEmail';
            }
            return null;
          },
          onSaved: (value) {
            _changeemail = value as String;
            changeemailHandler(_changeemail);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            hintText: AppLocalizations.of(context)!.new_email,
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
    return _checkChangeEmail(context);
  }
}
