// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
    required this.passwordHandler,
  });

  @override
  State<Password> createState() => _PasswordState();
  final Function passwordHandler;
}

class _PasswordState extends State<Password> {
  String _passWord = '';
  String _passWords = '';
  bool showPass2 = true;
  String enterPasswordAgain = '';
  String enterPasswordAgains = '';
  bool showPass = true;
  Widget _enterPassword(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white.withOpacity(0.7),
        child: TextFormField(
          obscureText: showPass,
          validator: (value) {
            _passWords = value as String;
            if (_passWords.isEmpty) {
              return 'Password must\'nt be empty!';
            }
            if (_passWords.length < 6) {
              return 'Password is too weak!';
            }
            return null;
          },
          onSaved: (value) {
            _passWord = _passWords;
            widget.passwordHandler(_passWord);
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass = !showPass;
                });
              },
              icon: showPass
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            icon: const Icon(Icons.lock),
            hintText: AppLocalizations.of(context)!.password,
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
    return _enterPassword(context);
  }
}
