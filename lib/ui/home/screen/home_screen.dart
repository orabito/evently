import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/ui/create_event/screen/create_event_screen.dart';
import 'package:event_planning_app/ui/home/tab/heart_tab/heart_tab.dart';
import 'package:event_planning_app/ui/home/tab/home_tab/home_tap.dart';
import 'package:event_planning_app/ui/home/tab/map_tab/map_tab.dart';
import 'package:event_planning_app/ui/home/tab/profile_tab/profile_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/assets_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTap(), MapTab(), HeartTab(), ProfileTab()];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirestoreHandler.getUser(FirebaseAuth.instance.currentUser?.uid??"0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        heroTag: "createEvent",
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEventScreen.routeName);
        },
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white, width: 5),
        ),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetsManager.home),
                activeIcon: SvgPicture.asset(
                  AssetsManager.homeSelected,
                  fit: BoxFit.cover,
                ),
                label: StringsManager.home.tr()),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetsManager.map),
                activeIcon: SvgPicture.asset(
                  AssetsManager.mapSelected,
                  theme: SvgTheme(
                    currentColor: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
                label: StringsManager.map.tr()),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetsManager.heart),
                activeIcon: SvgPicture.asset(
                  AssetsManager.heartSelected,
                  fit: BoxFit.cover,
                ),
                label: StringsManager.love.tr()),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetsManager.user),
                activeIcon: SvgPicture.asset(AssetsManager.userSelected),
                label: StringsManager.profile.tr()),
          ]),
      body: tabs[selectedIndex],
    );
  }
}
