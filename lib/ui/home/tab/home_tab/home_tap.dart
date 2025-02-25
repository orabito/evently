import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/providers/user_Provider.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/widget/all_event.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/widget/birthday_event.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/widget/book_event.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/widget/sport_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_manager.dart';
import '../../../../core/geocoding_helper.dart';
import '../../../../core/strings_manager.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}
// with SingleTickerProviderStateMixin
class _HomeTapState extends State<HomeTap> {
  int selectedIndex = 0;

  // late TabController _tabController;
  // @override
  // void initState() {
  //   super.initState();
  //
  //
  //   _tabController = TabController(length: 4, vsync: this);
  //
  //
  //   _tabController.addListener(() {
  //
  //       setState(() {
  //         selectedIndex = _tabController.index;
  //       });
  //
  //   });
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider=Provider.of<LocationProvider>(context);
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 4,
      child:
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child:
            Row(
              children: [

                Expanded(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringsManager.welcomeBack.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                userProvider.isLoading
                                    ? CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.secondary,
                                )
                                    :
                                Text(
                                  userProvider.user?.name??StringsManager.noUserFound.tr(),
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Gap(8),

                              ],
                            ),
                          ),
                          Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (themeProvider.currentTheme == ThemeMode.dark) {
                                          themeProvider.changeTheme(ThemeMode.light);
                                        } else {
                                          themeProvider.changeTheme(ThemeMode.dark);
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      themeProvider.currentTheme == ThemeMode.dark
                                          ? AssetsManager.moonIcon
                                          : AssetsManager.sunIcon,
                                      colorFilter:
                                      ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      height: 30,
                                      width: 30,
                                    )),
                                Gap(16),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: ElevatedButton(
                                  
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero  ,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8))),
                                    onPressed: () {
                                      setState(() {
                                        if (context.locale.languageCode == 'ar') {
                                          context.setLocale(Locale('en'));
                                        } else {
                                          context.setLocale(Locale('ar'));
                                        }
                                      });
                                    },
                                    child: Text(
                                      StringsManager.en.tr(),
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                )
                              ]),
                        ],
                      ),


                      Row(
                        children: [
                          SvgPicture.asset(AssetsManager.map),
                          Gap(8),
                          Expanded(
                            child:
                            locationProvider.eventLocation != null
                                ? FutureBuilder<String>(
                              future:GeocodingHelper. getShortAddressFromCoordinates(
                                locationProvider.eventLocation!.latitude,
                                locationProvider.eventLocation!.longitude,
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
                                : Text("Cairo Egypt ",
                              style: Theme.of(context). textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ),
                        ],
                      ),
                      Gap(8),
                      TabBar(
                        // controller:_tabController ,

                          tabAlignment: TabAlignment.start,
                          onTap: (value) {

                            setState(() {selectedIndex = value;});
                          },
                          isScrollable: true,
                          dividerHeight: 0,
                          indicator: BoxDecoration(

                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                  width: 2),
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                              borderRadius: BorderRadius.circular(46)),
                          tabs: [
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2,
                                        color: Theme.of(context).colorScheme.onPrimaryFixed
                                    ),
                                  borderRadius: BorderRadius.circular(46)

                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.compass,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 0
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.all.tr()),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2,
                                        color: Theme.of(context).colorScheme.onPrimaryFixed
                                    ),
                                    borderRadius: BorderRadius.circular(46)

                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.bike,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
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
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2,
                                        color: Theme.of(context).colorScheme.onPrimaryFixed
                                    ),
                                    borderRadius: BorderRadius.circular(46)

                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.cake,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 2
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.birthday.tr()),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2,
                                        color: Theme.of(context).colorScheme.onPrimaryFixed
                                    ),
                                    borderRadius: BorderRadius.circular(46)

                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsManager.book,
                                      colorFilter: ColorFilter.mode(
                                          selectedIndex == 3
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                          BlendMode.srcIn),
                                    ),
                                    Gap(8),
                                    Text(StringsManager.bookClub.tr()),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      Gap(10),

                    ],
                  ),

                ),


              ],
            ),
          ),

          Gap(10),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TabBarView(
                    // controller: _tabController,
physics: NeverScrollableScrollPhysics(),
                    children: [
                      AllEvent(),
                      SportEvent(),
                      BirthdayEvent(),
                      BookEvent()


                ])),
          )
        ],
      ),
    );
  }
}
