// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/controller/syriatel_cash/messages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Location with ChangeNotifier {
  Future<Position> getUserLocation({required BuildContext context}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, request user to enable it
      await Geolocator.requestPermission();
      // Show a dialog or display a message explaining the issue and how to enable location services
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.location_service_dis,
          ),
          content: Text(
            AppLocalizations.of(context)!.please_enable_location,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Open device settings to enable location services
                Geolocator.openLocationSettings();
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                AppLocalizations.of(context)!.enable_location,
              ),
            ),
            TextButton(
              onPressed: () {
                showError(
                  context,
                  AppLocalizations.of(context)!.location_not_enabled,
                  AppLocalizations.of(context)!.enable_location,
                );
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
              ),
            ),
          ],
        ),
      );
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromLatLng(
      {required double latitude, required double longitude}) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['address'].isNotEmpty) {
        // Extract address components from the response
        String address = "";
        if (data['address']['road'] != null) {
          address += data['address']['road'] + ", ";
        }
        if (data['address']['city'] != null) {
          address += data['address']['city'] + ", ";
        }
        if (data['address']['country'] != null) {
          address += data['address']['country'];
        }
        return address.trim();
      } else {
        return "Address not found";
      }
    } else {
      // Handle error retrieving address
      return "Failed to get address";
    }
  }
  //  Position position = await getUserLocation();
  //   String address = await getAddressFromLatLng(
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //   );

  //   // Use the formatted coordinates or address for delivery processing
  //   print("Delivery Address: $address");
  //   // Access latitude and longitude for delivery processing
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;

  //   // (Optional) Access accuracy if needed
  //   double accuracy = position.accuracy;
  //   print(latitude);
  //   print(longitude);
  //   print(accuracy);

//   Future<String> getAddress(double lat, double lon) async {
//   final url =
//       'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon';

//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final address = data['display_name'];
//     return address;
//   }
//   return null;
// }
}
