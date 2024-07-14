import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ChangePhoneNumber extends StatelessWidget {
  final Function changePhoneHandler;
  ChangePhoneNumber({super.key, required this.changePhoneHandler});
  String _changephoneNumber = '';
  Widget _enterChangePhoneNumber(BuildContext context) {
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
          keyboardType: TextInputType.number,
          maxLength: 10,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number must\'nt be empty!';
            }
            if (value.length == 1) {
              return 'Phone Number must start with 09';
            }
            if (value.substring(0, 2) != '09') {
              return 'Phone Number must start with 09********';
            }

            if (value.length < 10) {
              return 'Phone Number must be 10 digits';
            }

            return null;
          },
          onSaved: (value) {
            _changephoneNumber = value as String;
            changePhoneHandler(_changephoneNumber);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            hintText: AppLocalizations.of(context)!.new_phonenumber,
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
    return _enterChangePhoneNumber(context);
  }
}
