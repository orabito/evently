import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/onboarding/screen/onboarding_screen.dart';
import 'package:event_planning_app/ui/start_screen/widget/theme_toggle.dart';

import 'package:event_planning_app/ui/start_screen/widget/toggle_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  static const String routeName = "StartScreen";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            themeProvider.currentTheme == ThemeMode.dark
                                ? AssetsManager.designer_des
                                : AssetsManager.beingCreative,
                          )),
                    ),
                    Text(
                      StringsManager.personalizeEx.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Gap(28),
                    Text(
                      StringsManager.startDesc.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 20
                      ),
                    ),
                    Gap(28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.language.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        ToggleLanguage(),
                      ],
                    ),
                    Gap(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.theme.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        ThemeToggle(),
                      ],
                    ),
                    Gap(14),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OnboardingScreen.routeName);
                },
                text: StringsManager.letsStart.tr(),
              ),
            ],
          ),
        ));
  }
}
