
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingHelper {

  static Future<String> getShortAddressFromCoordinates(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String country = place.administrativeArea?.trim() ?? "";


        String admin = place.subAdministrativeArea ?? "";

        String result = "";
        if (country.isNotEmpty && admin.isNotEmpty) {
          result = "${country.toLowerCase()} ${admin.toLowerCase()}";
        } else if (admin.isNotEmpty) {
          result = admin.toLowerCase();
        } else if (country.isNotEmpty) {
          result = country.toLowerCase();
        }

        return result.isNotEmpty ? result :StringsManager.unknownLocation.tr();
      }
      return StringsManager.unknownLocation.tr();
    } catch (e) {
      return StringsManager.errorRetrievingLocation.tr();
    }
  }



}