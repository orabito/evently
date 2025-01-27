import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_manager.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int currentValue = 0;

  @override
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
