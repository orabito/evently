import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingHelper {
  static Future<String> getShortAddressFromCoordinates(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // نستخدم حقل الدولة (country) مع الـ administrativeArea
        String country = place.country?.trim() ?? "";
        String admin = place.administrativeArea?.trim() ?? "";

        String result = "";
        if (country.isNotEmpty && admin.isNotEmpty) {
          result = "${country.toLowerCase()} ${admin.toLowerCase()}";
        } else if (admin.isNotEmpty) {
          result = admin.toLowerCase();
        } else if (country.isNotEmpty) {
          result = country.toLowerCase();
        }

        return result.isNotEmpty ? result : "unknown location";
      }
      return "unknown location";
    } catch (e) {
      return "error retrieving location";
    }
  }



}