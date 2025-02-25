import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/constans.dart';
import 'package:event_planning_app/core/dialog_utils.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:event_planning_app/core/reusable_componets/custom_field.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/models/event_model.dart';
import 'package:event_planning_app/providers/event_provider.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/create_event/screen/pick_location_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/assets_manager.dart';
import '../../../core/geocoding_helper.dart';




class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({super.key,});

  static const String routeName = "CreateEventScreen";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  late TextEditingController controller;
  late TextEditingController descController;
  GlobalKey<FormState>formKey = GlobalKey<FormState>();

  bool _locationCleared = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    descController = TextEditingController();

  }
  @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//  eventModel=ModalRoute.of(context)?.settings.arguments as EventModel?;
// if(eventModel!=null){
//   controller=TextEditingController(text: eventModel?.tittle??"");
//   descController=TextEditingController(text: eventModel?.description??"");
//   selectedDate=DateTime.fromMillisecondsSinceEpoch(eventModel!.date!.millisecondsSinceEpoch);
//   selectedTime = TimeOfDay.fromDateTime(eventModel!.date!.toDate());
// selectedIndex=selectedIndexOfCategory();
//
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     final locationProvider = Provider.of<LocationProvider>(context, listen: false);
//
//     if (eventModel!.lat != null && eventModel!.long != null) {
//
//       locationProvider.eventLocation=LatLng(eventModel!.lat !, eventModel!.long !);
//
//   }});
//
// }
//
//
//   }
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_locationCleared) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(context, listen: false).clearLocation();
      _locationCleared = true;
    });
  }}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    descController.dispose();

  }

  Widget build(BuildContext context) {


ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

        appBar: AppBar(

          title: Text(
            StringsManager.createEvent.tr()
    ,        style: Theme
                .of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme
                .of(context)
                .colorScheme
                .primary),
          ),
        ),
        body: Consumer<LocationProvider>(builder: (context, provider, child) {

          return DefaultTabController(

            length: 3,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * .25,
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),

                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(  themeProvider.currentTheme==ThemeMode.dark?AssetsManager.bookEventDark:
                                    AssetsManager.bookEvent,
                                    height: height * .25,
                                    fit: BoxFit.cover,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    themeProvider.currentTheme==ThemeMode.dark?AssetsManager.sportEventDark:
                                    AssetsManager.sportEvent,
                                    height: height * .25,
                                    fit: BoxFit.cover,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(themeProvider.currentTheme==ThemeMode.dark?AssetsManager.birthdayEventDark:
                                    AssetsManager.birthdayEvent,
                                    height: height * .25,
                                    fit: BoxFit.cover,
                                  )),
                            ]),
                      ),
                      // ThemeToggle(),
                      // ToggleLanguage(),
                      Gap(15),
                      TabBar(
                          labelColor: Theme
                              .of(context)
                              .colorScheme
                              .onPrimary,
                          unselectedLabelColor: Theme
                              .of(context)
                              .colorScheme
                              .primary,

                          // controller:_tabController ,


                          tabAlignment: TabAlignment.start,
                          onTap: (value) {
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                          isScrollable: true,
                          dividerHeight: 0,
                          indicator: BoxDecoration(

                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  width: 5),
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              borderRadius: BorderRadius.circular(46)),
                          tabs: [
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(46)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.book,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 0
                                              ? Theme
                                              .of(context)
                                              .colorScheme
                                              .onPrimary
                                              : Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.bookClub.tr()),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(46)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.bike,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 1
                                              ? Theme
                                              .of(context)
                                              .colorScheme
                                              .onPrimary
                                              : Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.sport.tr()),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(46)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.cake,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 2
                                              ? Theme
                                              .of(context)
                                              .colorScheme
                                              .onPrimary
                                              : Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.birthday.tr()),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      Gap(10),
                      Text(
                        StringsManager.title.tr(), style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,),
                      Gap(8),
                      CustomField(
                        keyboard: TextInputType.text,
                        hint: StringsManager.eventTitle.tr(),
                        prefix: AssetsManager.noteEdit,
                        controller: controller,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return StringsManager.should_dntEmpty.tr();
                          }
                          return null;
                        },
                      ),
                      Gap(10),
                      Text(
                        StringsManager.description.tr(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                      Gap(8),
                      CustomField(
                        maxLine: 5,
                        keyboard: TextInputType.text,
                        hint: StringsManager.eventDescription.tr(),
                        controller: descController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return StringsManager.should_dntEmpty.tr();
                          }
                          return null;
                        },
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 32,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                          ),
                          Gap(5),
                          Expanded(
                            child: Text(StringsManager.eventDate.tr(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall),
                          ),

                          TextButton(
                            onPressed: () {
                              chooseEventDate();
                            },
                            child: Text(
                                selectedDate != null
                                    ? "${selectedDate?.day}/${selectedDate
                                    ?.month}/${selectedDate?.year}"
                                    : StringsManager.chooseDate.tr(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 32,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                          ),
                          Gap(5),
                          Expanded(
                            child:
                            Text(StringsManager.eventTime.tr(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall, maxLines: 1,),
                          ),

                          TextButton(
                            onPressed: () {
                              chooseEventTime();
                            },
                            child: Text(selectedTime != null ?
                            "${selectedTime?.hourOfPeriod}:${selectedTime
                                ?.minute} ${selectedTime?.period.name}"
                                : StringsManager.chooseTime.tr(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium),
                          )
                        ],
                      ),

                      Text(StringsManager.location.tr(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall, maxLines: 1,),
                      OutlinedButton(onPressed: () {
                        Navigator.of(context).pushNamed(
                            PickLocationScreen.routeName, arguments:provider);
                      },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(

                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary, width: 2),
                        ),

                        child: Row(

                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary),

                              child: Icon(Icons.my_location,
                                  size: 32,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onPrimary),
                            ),
                            Gap(10),
                            Expanded(
                              child:
                              provider.eventLocation != null
                                  ? FutureBuilder<String>(
                                future:GeocodingHelper. getShortAddressFromCoordinates(
                                  provider.eventLocation!.latitude,
                                  provider.eventLocation!.longitude,
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
                            Icon(Icons.arrow_forward_ios,
                                size: 32,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary),
                          ],
                        ),), Gap(10),

                      Container(
                        width: double.infinity,
                        child: CustomButton(
                            text: StringsManager.addEvent.tr(),
                            onPressed: () {
                              createEvent(provider);
                            }
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );

        })

    );
  }

  // variable
  DateTime? selectedDate;

  chooseEventDate() async {
    DateTime? tempDate = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        initialDate: selectedDate
      // initialTime: TimeOfDay.now(),


    );
    setState(() {
      if (tempDate != null) {
        selectedDate = tempDate;
      }
    });
  }

  TimeOfDay? selectedTime;

  chooseEventTime() async {
    TimeOfDay? tempTime = await showTimePicker(
      context: context,
      initialTime: selectedTime != null ? selectedTime! : TimeOfDay.now(),
    );

    if (tempTime != null) {
      setState(() {
        selectedTime = tempTime;
      });
    }
  }

  createEvent(LocationProvider provider) async {

    if (formKey.currentState!.validate()) {
      if (selectedTime != null && selectedDate != null) {
        if(provider.eventLocation!=null){
          DateTime eventDate = DateTime(
              selectedDate!.year, selectedDate!.month, selectedDate!.day,
              selectedTime!.hour, selectedTime!.minute);
          DialogUtils.showLoadingDialog(context);
          await FirestoreHandler.createEvent(EventModel(
            lat:provider.eventLocation!.latitude
            ,long: provider.eventLocation!.longitude,
            tittle: controller.text,
            description: descController.text,
            // isWishList: false,

            date: Timestamp.fromDate(eventDate),
            uId: FirebaseAuth.instance.currentUser!.uid,
            category: selectedCategory(),

          ));
          Navigator.pop(context);
          DialogUtils.showToast(
              StringsManager.eventAddedSuccessfully.tr(), context);
        }else{
          DialogUtils.showToast(StringsManager.tapOnLocationToSelect.tr(), context);
        }

      } else {
        DialogUtils.showToast(StringsManager.enterDateTime.tr(), context);
      }
    }
  }

  String selectedCategory() {
    if (selectedIndex == 0) {
      return bookCategory;
    } else if (selectedIndex == 1) {
      return sportCategory;
    } else {
      return birthdayCategory;
    }
  }
}
