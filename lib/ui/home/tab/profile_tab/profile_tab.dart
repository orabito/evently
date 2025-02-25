import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/providers/user_Provider.dart';
import 'package:event_planning_app/ui/home/tab/profile_tab/widget/language_show_modal_bottom_sheet_widget.dart';
import 'package:event_planning_app/ui/home/tab/profile_tab/widget/theme_show_modal_bottom_sheet_widget.dart';
import 'package:event_planning_app/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Provider.of<ThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: height * .23,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: height * .15,
                      padding: EdgeInsets.all(16),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(1000),
                              bottomEnd: Radius.circular(1000),
                              topEnd: Radius.circular(1000))),
                      child: SvgPicture.asset(
                        AssetsManager.person,
                        height: 20,
                      )),
                ),
                Gap(16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userProvider.isLoading?
                    CircularProgressIndicator():
                    Text(
                      userProvider.user?.name??StringsManager.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Gap(8),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ??
                         StringsManager.noUserFound.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Gap(8),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.language.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Gap(15),
                InkWell(
                  onTap:
                  () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => LanguageShowModalBottomSheetWidget(),);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.locale.languageCode == "en"
                              ? StringsManager.english.tr()
                              : StringsManager.arabic.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(15),
                Text(
                  StringsManager.theme.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Gap(15),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(context: context,
                        builder: (context) => ThemeShowModalBottomSheetWidget(),);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeProvider.currentTheme == ThemeMode.light
                              ? StringsManager.light.tr()
                              : StringsManager.dark.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(style:ElevatedButton.styleFrom(
                     backgroundColor: Colors.red,
                     padding: EdgeInsets.all(16)
                       ,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(16),
                     )
                   ) ,onPressed: (){

                     FirebaseAuth.instance.signOut();
                     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                   },
                       child: Row(
                         children: [
                           Icon(Icons.logout, color:  Colors.white,),
                           Gap(16),
                           Text(StringsManager.logout.tr(),style: TextStyle(
                             color:  Colors.white,
                             fontSize: 24,

                           ),)
                         ],
                       )),
                 )
              ],
            ),
          ),
        )
      ],
    );
  }
}
