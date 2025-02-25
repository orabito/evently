import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/ui/home/tab/map_tab/widget/map_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/reusable_componets/firestore_handler.dart';
import '../../../../core/strings_manager.dart';
import '../../../../models/event_model.dart';


class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   provider= Provider.of(context,listen: false);
  //   provider.getLocation();
  // }
 late LocationProvider provider;

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    provider.cancelLocationSubscription();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LocationProvider>(context);
    return Consumer<LocationProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FloatingActionButton(
                heroTag: "mapTabFab",
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  provider.getLocation();
                },
                child: Icon(
                  Icons.gps_fixed,
                  size: 32,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        markers: provider.markers,
                        initialCameraPosition: provider.cameraPosition,
                        onMapCreated: (mapController) {
                          provider.mapController = mapController;
                          provider.setLocationListener();
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: StreamBuilder(stream: FirestoreHandler.getAllEventsStream(),
                    builder:(context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        //in loading state
                        return Center(child: CircularProgressIndicator());
                      }else if(snapshot.hasError){
                        //en error state\
                        return Text(snapshot.hasError.toString());
                      }else{
                        List<EventModel>events=snapshot.data??[];
                        return events.isEmpty? Center(child: Text(StringsManager.noEventFound.tr()))
                            : ListView.separated(
                          padding: EdgeInsets.all(8),
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                SizedBox(
                                  width: 350,
                                  child:
                                  MapCardWidget(
                                      eventModel: events[index],
                                      onPressed: (lat, long) {
                                        provider.seeLocationOfEvent(LatLng(lat, long));
                                      },
                                    )
                                ),
                            separatorBuilder: (context, index) => Gap(8),
                            itemCount: events.length);
                        //in success state
        
                      }
        
        
                    },
                  ),
                )
              ],
            ),),
      );
    });
  }
}
