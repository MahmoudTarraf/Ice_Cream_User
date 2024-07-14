// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReEnterPassword extends StatefulWidget {
  const ReEnterPassword({
    super.key,
    required this.setReEnterPasswordHandler2,
  });

  @override
  State<ReEnterPassword> createState() => _ReEnterPasswordState();
  final Function setReEnterPasswordHandler2;
}

class _ReEnterPasswordState extends State<ReEnterPassword> {
  String _ReEnterpassWord = '';
  String _ReEnterpassWords = '';
  bool showPass2 = true;
  String enterReEnterPasswordAgain = '';
  String enterReEnterPasswordAgains = '';
  bool showPass = true;
  Widget _enterReEnterPassword() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          obscureText: showPass,
          validator: (value) {
            _ReEnterpassWords = value as String;
            if (_ReEnterpassWords.isEmpty) {
              return 'Password must\'nt be empty!';
            }
            if (_ReEnterpassWords.length < 6) {
              return 'Password is too weak!';
            }
            return null;
          },
          onSaved: (value) {
            _ReEnterpassWord = _ReEnterpassWords;
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

  Widget _reEnterReEnterPassword() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          obscureText: showPass2,
          validator: (value) {
            enterReEnterPasswordAgains = value as String;
            if (enterReEnterPasswordAgains.isEmpty) {
              return 'Password must\'nt be empty!';
            }
            if (enterReEnterPasswordAgains != _ReEnterpassWords) {
              return 'This password doesn\'t match the previous one !';
            }
            if (enterReEnterPasswordAgains.length < 6) {
              return 'Password is too weak!';
            }
            return null;
          },
          onSaved: (value) {
            enterReEnterPasswordAgain = enterReEnterPasswordAgains;
            widget.setReEnterPasswordHandler2(
              enterReEnterPasswordAgain,
            );
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass2 = !showPass2;
                });
              },
              icon: showPass2
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            icon: const Icon(Icons.lock),
            hintText: AppLocalizations.of(context)!.enter_pass_again,
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _enterReEnterPassword(),
        const SizedBox(
          height: 10,
        ),
        _reEnterReEnterPassword(),
      ],
    );
  }
}
