import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PhoneNumber extends StatelessWidget {
  final Function phoneHandler;
  PhoneNumber({super.key, required this.phoneHandler});
  String _phoneNumber = '';
  Widget _enterPhoneNumber(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        color: Colors.white.withOpacity(0.7),
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
            _phoneNumber = value as String;
            phoneHandler(_phoneNumber);
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            hintText: AppLocalizations.of(context)!.phoneNumber_profile,
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
    return _enterPhoneNumber(context);
  }
}
