// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:convert';
import 'package:graduation_project/controller/providers/other_stuff_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/model/special_offer_model.dart';
import 'package:provider/provider.dart';

class SpecialOffersProvider with ChangeNotifier {
  //
  List<SpecialOffer> _theseOffers = [];
  List<SpecialOffer> get getOffers => _theseOffers;
  //

  void setOffer(SpecialOffer offer) {
    _theseOffers.add(
      SpecialOffer(
        category: offer.category,
        details: offer.details,
        image: offer.image,
        title: offer.title,
        newPrice: offer.newPrice,
        oldPrice: offer.oldPrice,
      ),
    );
    notifyListeners();
  }

  void resetOffer() {
    _theseOffers = [];
  }

  //
  Future<void> getAllOffers({required BuildContext context}) async {
    resetOffer();
    final response = await http.get(
      Uri.parse(
        '${Config.url}getalloffers/',
      ),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List;

      _theseOffers =
          responseData.map((data) => SpecialOffer.fromJson(data)).toList();
      Provider.of<OtherStuffProvider>(context, listen: false)
          .setOffers(_theseOffers);
    }
  }
}
