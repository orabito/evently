import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/constans.dart';

import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/models/event_model.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/providers/user_Provider.dart';
import 'package:event_planning_app/ui/EventDetails/screen/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  const EventItem({super.key,required this.event});
final EventModel event;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    UserProvider userProvider=Provider.of<UserProvider>(context);
    double height = MediaQuery.of(context).size.height;
    List<String>userFavoriteEventId = userProvider.user?.favorite??[];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap:(){
          Navigator.of(context).pushNamed(EventDetailsScreen.routeName,arguments: widget.event);
        },
        child: Container(
          height: height * .25,
          decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color:  Theme.of(context).colorScheme.primary
            ),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                  getImageByCategory(themeProvider),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 ),
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                child: Column(
                  children: [
                    Text(
                     widget.event.date!.toDate().day.toString() ,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat.MMM().format(widget.event.date!.toDate()).toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 ),
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                      widget.event.tittle??"",
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (userFavoriteEventId.contains(widget.event.eventId)) {
                          userProvider.user?.favorite
                              ?.remove(widget.event.eventId ?? "");
                          await FirestoreHandler.removeFromFavorite(
                               widget.event.eventId ?? "",
                              FirebaseAuth.instance.currentUser!.uid);

                          await FirestoreHandler.updateUserFavorites(
                              FirebaseAuth.instance.currentUser!.uid,
                              userProvider.user?.favorite ?? []);

                          // Ensure context is valid before popping
                        } else {
                          userProvider.user?.favorite
                              ?.add(widget.event.eventId ?? "");
                          await FirestoreHandler.addToFavorite(
                              FirebaseAuth.instance.currentUser!.uid, widget.event);

                          await FirestoreHandler.updateUserFavorites(
                              FirebaseAuth.instance.currentUser!.uid,
                              userProvider.user?.favorite ?? []);
                        }
                        if (mounted) {
                          setState(() {});
                        }

                        // Ensure context is valid before popping
                        // if (mounted && Navigator.of(context).canPop()) {
                        //   Navigator.pop(context);
                        // }
                      },
                      child: SvgPicture.asset(
                        userFavoriteEventId.contains(widget.event.eventId)
                            ? AssetsManager.heartSelected
                            : AssetsManager.heart,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getImageByCategory(ThemeProvider themeProvider){
    if(widget.event.category==sportCategory){
      return themeProvider.currentTheme==ThemeMode.light?  AssetsManager.sportEvent:AssetsManager.sportEventDark;
    }else if(widget.event.category==bookCategory){
      return themeProvider.currentTheme == ThemeMode.light
          ? AssetsManager.bookEvent
          : AssetsManager.bookEventDark;
    }else{
      return themeProvider.currentTheme == ThemeMode.light
          ? AssetsManager.birthdayEvent
          : AssetsManager.birthdayEventDark;
    }
  }
}
