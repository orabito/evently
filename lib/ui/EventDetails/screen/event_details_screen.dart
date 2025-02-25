import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/dialog_utils.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/core/reusable_componets/outline_button_widget.dart';
import 'package:event_planning_app/core/strings_manager.dart';

import 'package:event_planning_app/ui/update_event/screen/update_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/constans.dart';
import '../../../core/geocoding_helper.dart';
import '../../../models/event_model.dart';
import '../../../providers/theme_provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});
static const String routeName="EventDetailsScreen" ;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    double height=MediaQuery.of(context).size.height;
    EventModel eventModel=ModalRoute.of(context)?.settings.arguments as EventModel ;
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
        title: Text(StringsManager.eventDetailsS.tr(),
        style: Theme.of(context).textTheme.titleMedium,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FirebaseAuth.instance.currentUser?.uid==eventModel.uId? Row(
              children: [
                InkWell(

                    onTap: () =>Navigator.of(context).pushNamed(UpdateEventScreen.routeName,arguments: eventModel) ,
                    child: SvgPicture.asset(AssetsManager.pen)),
                Gap(8),
                InkWell(
                    onTap: () {
                      deleteEvent(eventModel);
                    },
                    child: SvgPicture.asset(AssetsManager.delete))
              ],
            ):SizedBox.shrink(),
          ),
        ],
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  getImageByCategory(themeProvider, eventModel),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height * .25,
                ),
              ),
              Gap(16),
              Text(
                eventModel.tittle!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 24),
              ),
              Gap(16),
              OutlineButtonWidget(
                Onpressed: () {},
                icon: Icons.calendar_month,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd()
                          .format(eventModel.date!.toDate())
                          .toString(),
                    ),
                    Text(
                      DateFormat.jm()
                          .format(eventModel.date!.toDate())
                          .toString(),
                    ),
                  ],
                ),
              ),
              Gap(16),
              OutlineButtonWidget(
                Onpressed: () {},
                icon: Icons.my_location,
                child: Row(
                  children: [
                    Expanded(
                      child:
                      eventModel.lat != null
                          ? FutureBuilder<String>(
                        future:GeocodingHelper. getShortAddressFromCoordinates(
                          eventModel.lat!,
                          eventModel.long!,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(StringsManager.loadingAddress.tr());
                          } else if (snapshot.hasError) {
                            return Text(StringsManager.errorRetrievingLocation.tr());
                          } else {
                            return Text(snapshot.data ?? StringsManager.unknownLocation.tr());
                          }
                        },
                      )
                          : Text(StringsManager.chooseEventLocation.tr()),
                    ),
                  ],
                ),
              ),
              Gap(16),
              Container(
                width: double.infinity,
                height: height * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    scrollGesturesEnabled: false,
                    myLocationEnabled: true,
                    markers: {
                      Marker(
                        position: LatLng(
                          eventModel.lat ?? 0,
                          eventModel.long ?? 0,
                        ),
                        markerId: MarkerId(
                          "0",
                        ),
                      )
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                          eventModel.lat ?? 0,
                          eventModel.long ?? 0,
                        ),
                        zoom: 17),
                  ),
                ),
              ),
              Gap(16),
              Text(
                StringsManager.description.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              Gap(16),
              Text(
                eventModel.description ?? "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getImageByCategory(ThemeProvider themeProvider, eventModel) {
    if (eventModel.category == sportCategory) {
      return themeProvider.currentTheme == ThemeMode.light
          ? AssetsManager.sportEvent
          : AssetsManager.sportEventDark;
    } else if (eventModel.category == bookCategory) {
      return themeProvider.currentTheme == ThemeMode.light
          ? AssetsManager.bookEvent
          : AssetsManager.bookEventDark;
    } else {
      return themeProvider.currentTheme == ThemeMode.light
          ? AssetsManager.birthdayEvent
          : AssetsManager.birthdayEventDark;
    }
  }

  deleteEvent(EventModel eventModel) async {
DialogUtils.showToast(StringsManager.eventDeleteSuccess.tr(), context);
   await FirestoreHandler.deleteEvent(eventModel)
    ;Navigator.pop(context);
  }
}
