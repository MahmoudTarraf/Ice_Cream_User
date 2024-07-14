import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class OperationNumber extends StatelessWidget {
  final Function operationNumberHandler;
  OperationNumber({super.key, required this.operationNumberHandler});
  String _operationNumber = '';
  Widget _enterOperationNumber(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(
            width: 7,
            color: Colors.black,
          ),
          color: Colors.white.withOpacity(0.7),
        ),
        // padding: const EdgeInsets.all(5),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Operation Number must\'nt be empty!';
            }
            if (value.length < 12) {
              return 'Operation Number is at least 12 characters!';
            }
            return null;
          },
          onSaved: (value) {
            _operationNumber = value as String;
            operationNumberHandler(_operationNumber);
          },
          decoration: InputDecoration(
            icon: const Icon(
              Icons.numbers,
              color: Colors.black,
            ),
            hintText: AppLocalizations.of(context)!.enter_operation_number,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterOperationNumber(context);
  }
}
