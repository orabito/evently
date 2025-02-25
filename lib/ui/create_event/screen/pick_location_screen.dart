import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/providers/location_provider.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key,required this.locationProvider});
final  LocationProvider locationProvider;
static const String routeName="PickLocationScreen";
  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {

 late LocationProvider locationProvider=widget.locationProvider ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: locationProvider,
      child: Consumer<LocationProvider>(
        builder:(context,locationProvider,child)=> Scaffold(
          body:
          Column(
            children: [
               Expanded(   child: GoogleMap(
                 onTap: (location) {
locationProvider.changeLocation(location);
Navigator.pop(context);
                 },
                 mapType: MapType.normal,
                 markers: locationProvider.markers,
                 initialCameraPosition: locationProvider.cameraPosition,
                 onMapCreated: (mapController) {
                   locationProvider.mapController = mapController;

                 },
               ),),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary

                ),
                child: Text(
                  StringsManager.selectLocation.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
