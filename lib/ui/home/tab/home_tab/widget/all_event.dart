import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/models/event_model.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/widget/event_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/strings_manager.dart';

class AllEvent extends StatelessWidget {
  const AllEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(stream: FirestoreHandler.getAllEventsStream(),
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
               itemBuilder: (context, index) =>
                   EventItem(
                     event:events[index]
                     // snapshot.data??[][index],i can do this also ,

                   ),
               separatorBuilder: (context, index) => Gap(8),
               itemCount: events.length);
           //in success state

         }


        },
       );
  }
}
