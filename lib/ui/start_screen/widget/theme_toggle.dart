import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import 'package:event_planning_app/core/prefs_helper.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/assets_manager.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int currentValue = 0;
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (PrefsHelper.getTheme()) {
        currentValue = 1;
      }
      else {
        currentValue = 0;
      }
      setState(() {

      });
    },);

  }


  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<int>.rolling(
      iconOpacity: 1,
      style: ToggleStyle(
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
      ),
      current: currentValue,
      values: [
        0,
        1,
      ],
      onChanged: (i) {
        setState(() {
          currentValue = i;
         if(currentValue==0){
          themeProvider.changeTheme(ThemeMode.light);


         }else{
           themeProvider.changeTheme(ThemeMode.dark);

         }
        });
      },
      iconList: [
        SvgPicture.asset(
          AssetsManager.sunIcon,
          colorFilter: ColorFilter.mode(
              currentValue == 0
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
          height: 30,
          width: 30,
        ),
        SvgPicture.asset(
          AssetsManager.moonIcon,
          colorFilter: ColorFilter.mode(
              currentValue == 1
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary, BlendMode.srcIn),
          height: 30,
          width: 30,
        ),
      ],
    );
  }
}
