import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ChangeUserName extends StatelessWidget {
  final Function changeuserNameHandler;
  ChangeUserName({
    super.key,
    required this.changeuserNameHandler,
  });
  String _changeuserName = '';
  Widget _checkChangeUserName(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.pink,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.7),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username must\'nt be empty!';
            }
            return null;
          },
          onSaved: (value) {
            _changeuserName = value as String;
            changeuserNameHandler(_changeuserName);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            hintText: AppLocalizations.of(context)!.new_username,
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
    return _checkChangeUserName(context);
  }
}
