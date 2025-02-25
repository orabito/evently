import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/reusable_componets/custom_field.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../../../core/assets_manager.dart';
import '../../../../core/reusable_componets/firestore_handler.dart';
import '../../../../models/event_model.dart';
import '../home_tab/widget/event_item.dart';

class HeartTab extends StatefulWidget {
  const HeartTab({super.key});

  @override
  State<HeartTab> createState() => _HeartTabState();
}

class _HeartTabState extends State<HeartTab> {
  late TextEditingController controller;
  List<EventModel>eventFilter=[];
  String searchValue = "";
late  List<EventModel> events;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Column(
          children: [
            CustomField(

onChanged: (value) {
  searchValue = value;
  searchEventWhere(searchValue, events);
  setState(() {});
},
              keyboard: TextInputType.text,
              hint: context.locale.languageCode == "ar"
                  ? StringsManager.searchForEvent.tr()
                  : StringsManager.searchForEvent.tr(),
              prefix: AssetsManager.search,
              controller: controller,
              validator: (p0) {
                return null;
              },
            ),

            Gap(16),
            Expanded(
                child: StreamBuilder(stream: FirestoreHandler.getMyWishlistStream(
                    FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //in loading state
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      //en error state\
                      return Text(snapshot.hasError.toString());
                    } else {
                      events = snapshot.data ?? [];
                      return  events.isEmpty ? Center(
                          child: Text(StringsManager.noEventFound.tr()))
                          : ListView.separated(
                          itemBuilder: (context, index) =>
                              EventItem(
                                  event: searchValue.isNotEmpty?eventFilter[index]: events[index]

                                // snapshot.data??[][index],i can do this also ,

                              ),
                          separatorBuilder: (context, index) => Gap(8),
                          itemCount: searchValue.isNotEmpty?eventFilter.length: events.length);
                      //in success state

                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
  void searchEventWhere(String searchText,   List<EventModel> events) {
    eventFilter = [];
    eventFilter = events
        .where((element) =>
    element.eventId!
        .toLowerCase()
        .contains(searchText.toLowerCase()) ||
        element.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

  }
}
