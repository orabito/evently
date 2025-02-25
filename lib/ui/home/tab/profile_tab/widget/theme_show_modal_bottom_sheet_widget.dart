import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings_manager.dart';

class ThemeShowModalBottomSheetWidget extends StatelessWidget {
  const ThemeShowModalBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(

                themeProvider.currentTheme==ThemeMode.light
                    ? StringsManager.light.tr()
                    : StringsManager.dark.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              )
            ],
          ),
          Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if ( themeProvider.currentTheme==ThemeMode.light ||
                      themeProvider.currentTheme!=ThemeMode.dark ) {
                    themeProvider.changeTheme(ThemeMode.dark);
                  } else {
                    themeProvider.changeTheme(ThemeMode.light);
                  }
                },
                child: Text(
                  themeProvider.currentTheme!=ThemeMode.light
                      ? StringsManager.light.tr()
                      : StringsManager.dark.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
