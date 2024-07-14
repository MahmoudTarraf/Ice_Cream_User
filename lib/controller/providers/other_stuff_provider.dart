import 'package:flutter/material.dart';
import 'package:graduation_project/model/ice_cream_model.dart';
import 'package:graduation_project/model/special_offer_model.dart';

class OtherStuffProvider with ChangeNotifier {
  //
  List<IceCream> classicFlavorsList = [];
  List<IceCream> _iceCreamsList = [];
  List<IceCream> _searchIceCreamList = [];
  List<SpecialOffer> theseOffers = [];
  List<IceCream> specialDessertList = [];
  List<IceCream> recentlyAddedList = [];
  List<IceCream> mostPopularList = [];
  List<IceCream> uniqueList = [];
  bool _reloadOffers = true;
  bool _reloadIceCreams = true;
  bool get getOffersCondition => _reloadOffers;
  bool get getIceCreamsCondition => _reloadIceCreams;
//
  void setOfferCondition(bool v) {
    _reloadOffers = v;
    notifyListeners();
  }

  void setIceCreamsCondition(bool m) {
    _reloadIceCreams = m;
    notifyListeners();
  }

//
  void setOtherLists(List icecreams) {
    _iceCreamsList = icecreams as List<IceCream>;
    _reloadIceCreams = false;
    classicFlavorsList = icecreams
        .where((element) => element.category == "Classic Flavors")
        .toList();
    specialDessertList = icecreams
        .where((element) => element.category == "Special Desserts")
        .toList();
    recentlyAddedList = icecreams
        .where((element) => element.category == "Recently Added")
        .toList();
    mostPopularList = icecreams
        .where((element) => element.category == "Most Popular")
        .toList();
    uniqueList =
        icecreams.where((element) => element.category == "unique").toList();
    notifyListeners();
  }

  void setOffers(List offers) {
    theseOffers = offers as List<SpecialOffer>;
    _reloadOffers = false;
    notifyListeners();
  }

  List<IceCream> searchIceCream(String title) {
    _searchIceCreamList = [];
    _searchIceCreamList = _iceCreamsList
        .where(
          (element) => element.title.contains(title),
        )
        .toList();
    return _searchIceCreamList;
  }

  void resetLists() {
    _searchIceCreamList = [];
    _iceCreamsList = [];
    mostPopularList = [];
    recentlyAddedList = [];
    specialDessertList = [];
    classicFlavorsList = [];
    uniqueList = [];
    //notifyListeners();
  }
}
