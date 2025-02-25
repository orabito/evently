import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';

import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/models/onboarding_model.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/login/screen/login_screen.dart';
import 'package:event_planning_app/ui/onboarding/widget/onboarding_widget.dart';
import 'package:event_planning_app/ui/start_screen/widget/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:provider/provider.dart';

import '../../../core/prefs_helper.dart';


class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  static const String routeName = "OnboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController.addListener(() {
      currentIndex = pageController.page?.toInt() ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [
            Gap(10),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => OnboardingWidget(
                  image: onboardingListByProvider(themeProvider)[index].image,
                  title: onboardingListByProvider(themeProvider)[index].title,
                  textBody:
                      onboardingListByProvider(themeProvider)[index].bodyText,
                ),
                itemCount: onboardingListByProvider(themeProvider).length,
                controller: pageController,
              ),
            ),
            ThemeToggle(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      icon: currentIndex == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.primary,
                                    width: 2),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).colorScheme.primary,
                              ))),
                  Row(
                    children: List.generate(
                      onboardingListByProvider(themeProvider).length,
                      (index) {
                        return Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              height: 10,
                              width: currentIndex == index ? 30 : 10,
                              decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(15)),
                            ));
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentIndex <
                          onboardingListByProvider(themeProvider).length - 1) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 1),
                            curve: Curves.easeInOut);
                      } else {
                        setOnboardingIsDone();
                      }
                    },
                    icon: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<OnboardingModel> onboardingListByProvider(ThemeProvider themeProvider) {
    return [
      // OnboardingModel(
      //     titleSmall: StringsManager.personalizeEx.tr(),
      //     titleMedium: StringsManager.preferred.tr(),
      //     image: themeProvider.currentTheme == ThemeMode.light
      //         ? AssetsManager.smart_people
      //         : AssetsManager.wireframe_dark),
      OnboardingModel(
          title: StringsManager.findEvents.tr(),
          bodyText: StringsManager.findEventsDesc.tr(),
          image: themeProvider.currentTheme == ThemeMode.light
              ? AssetsManager.hotTrending
              : AssetsManager.hotTrendingDark),
      OnboardingModel(
          title: StringsManager.effortlessPlanning.tr(),
          bodyText: StringsManager.effortlessPlanningDesc.tr(),
          image: themeProvider.currentTheme == ThemeMode.light
              ? AssetsManager.manager_desk
              : AssetsManager.wireframeDark),
      OnboardingModel(
          title: StringsManager.connectShare.tr(),
          bodyText: StringsManager.connectShareDesc.tr(),
          image: themeProvider.currentTheme == ThemeMode.light
              ? AssetsManager.social_media
              : AssetsManager.uploading_dark),
    ];
  }
  void setOnboardingIsDone()async{
  await  PrefsHelper.setOnboarding(false);
  Navigator.pushNamed(context, LoginScreen.routeName);
  }
}
