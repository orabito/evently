import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/models/event_model.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../core/assets_manager.dart';
import '../../../../../core/constans.dart';
import '../../../../../core/geocoding_helper.dart';

class MapCardWidget extends StatelessWidget {
  const MapCardWidget({super.key,required this.eventModel,required this.onPressed});
final EventModel eventModel;
final Function(double,double)onPressed;
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return  GestureDetector(
      onTap:(){
        onPressed(eventModel.lat??0,eventModel.long??0);
      },
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width*.75,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,

            color: Theme.of(context).colorScheme.primary
          ),
          color: Theme.of(context).colorScheme.onInverseSurface
        ),
        child:
        Row(
          children: [
            AspectRatio(
                aspectRatio: 138 / 78,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      width: 30,
                      getImageByCategory(themeProvider),
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                    ))),
            Gap(8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(eventModel.tittle!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ),

                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  String getImageByCategory(ThemeProvider themeProvider) {
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
}
