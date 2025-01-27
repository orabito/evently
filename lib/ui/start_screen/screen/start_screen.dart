import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/ui/start_screen/widget/theme_toggle.dart';
import 'package:event_planning_app/ui/start_screen/widget/toggle_button.dart';
import 'package:event_planning_app/ui/start_screen/widget/toggle_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static const String routeName = "StartScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(AssetsManager.logo),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          AssetsManager.beingCreative,
                        ),
                      ),
                    ),
                    Text(
                      StringsManager.personalizeEx,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Gap(28),
                    Text(
                      StringsManager.startDesc,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gap(28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.language,
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
                          StringsManager.theme,
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
                onPressed: (){},
                text:StringsManager.letsStart,
              ),
            ],
          ),
        ));
  }
}
