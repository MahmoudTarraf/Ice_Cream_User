import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class SearchFieldHelper extends StatelessWidget {
  final Function searchHandler;
  final Function validteThis;
  SearchFieldHelper({
    super.key,
    required this.searchHandler,
    required this.validteThis,
  });

  Color lightColor = const Color.fromARGB(255, 253, 222, 231);

  Color darkColor = const Color.fromARGB(255, 219, 120, 148);
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '                Search must\'nt be empty!';
            }
            return null;
          },
          onSaved: (value) {
            _text = value as String;
            searchHandler(_text);
          },
          cursorColor: darkColor,
          style: TextStyle(
            color: darkColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: darkColor),
            hintText: AppLocalizations.of(context)!.search_your_icecream,
            hintStyle: TextStyle(
              color: darkColor,
              fontSize: 13,
            ),
            suffixIcon: GestureDetector(
              onTap: () => validteThis(),
              child: Container(
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.icecream,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
