import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_manager.dart';

class ToggleLanguage extends StatefulWidget {
  const ToggleLanguage({super.key});

  @override
  State<ToggleLanguage> createState() => _ToggleLanguageState();
}

class _ToggleLanguageState extends State<ToggleLanguage> {
  int currentValue = 0;

  @override
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     setState(() {
       if (context.locale.languageCode == "ar") {
         currentValue = 1;
       }
       else {
         currentValue = 0;

       }
     });

    },);

  }

  Widget build(BuildContext context) {
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
          if (currentValue == 0) {
            context.setLocale(Locale("en"));
          } else {
            context.setLocale(Locale("ar"));
          }
        });
      },
      iconList: [
        SvgPicture.asset(
          AssetsManager.englishIcon,
          height: 30,
          width: 30,
        ),
        SvgPicture.asset(
          AssetsManager.arabicIcon,
          height: 30,
          width: 30,
        ),
      ],
    );
  }
}
