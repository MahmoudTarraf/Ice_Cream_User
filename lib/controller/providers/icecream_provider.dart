// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_final_fields

import 'dart:convert';
import 'package:graduation_project/controller/providers/other_stuff_provider.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/controller/Auth/config.dart';
import 'package:graduation_project/model/ice_cream_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IceCreamProvider with ChangeNotifier {
  //

  static const thisUrl = Config.url;
  List<IceCream> _iceCreams = [];
  //
  Future<void> getIceCreams({required BuildContext context}) async {
    Provider.of<OtherStuffProvider>(context, listen: false).resetLists();
    final response = await http.get(
      Uri.parse(
        '${Config.url}geticecreams/',
      ),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List;

      _iceCreams = responseData.map((data) => IceCream.fromJson(data)).toList();
      Provider.of<OtherStuffProvider>(context, listen: false)
          .setOtherLists(_iceCreams);

      notifyListeners();
    } else {
      print('error : ${response.reasonPhrase}');
    }
  }
}
