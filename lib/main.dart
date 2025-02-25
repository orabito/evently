import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/app_style.dart';
import 'package:event_planning_app/core/prefs_helper.dart';
import 'package:event_planning_app/providers/event_provider.dart';
import 'package:event_planning_app/providers/location_provider.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/providers/user_Provider.dart';
import 'package:event_planning_app/ui/EventDetails/screen/event_details_screen.dart';
import 'package:event_planning_app/ui/create_event/screen/create_event_screen.dart';
import 'package:event_planning_app/ui/create_event/screen/pick_location_screen.dart';
import 'package:event_planning_app/ui/forget_password/screen/forget_password_screen.dart';
import 'package:event_planning_app/ui/home/screen/home_screen.dart';
import 'package:event_planning_app/ui/login/screen/login_screen.dart';
import 'package:event_planning_app/ui/onboarding/screen/onboarding_screen.dart';
import 'package:event_planning_app/ui/register/screen/register_screen.dart';

import 'package:event_planning_app/ui/start_screen/screen/start_screen.dart';
import 'package:event_planning_app/ui/update_event/screen/update_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  await PrefsHelper.getBool();
var isFirstTime=await PrefsHelper.getBool();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
        supportedLocales: [Locale("en"), Locale("ar")],
        fallbackLocale: Locale("en"),
        path: 'assets/translations',
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider()..initTheme(),
            ),
            ChangeNotifierProvider(
              create: (context) => LocationProvider(),
            ),
          ],
          child: MyApp(
            firstTime: isFirstTime,
          ),
        ),
  ),
  );
}

checkFirstTime() async{
var isFirstTime=await PrefsHelper.getBool();
return isFirstTime;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.firstTime});
final bool firstTime;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: themeProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        StartScreen.routeName: (_) => StartScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        EventDetailsScreen.routeName:(_)=>EventDetailsScreen(),
        HomeScreen.routeName: (_) => ChangeNotifierProvider(

            create: (context) => UserProvider()..getUser(),
            child: HomeScreen()),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        UpdateEventScreen.routeName:(context)=>UpdateEventScreen(),
        PickLocationScreen.routeName:(context){
          var provider=ModalRoute.of(context)?.settings.arguments as LocationProvider;
          return PickLocationScreen(
            locationProvider: provider,
          );
        },
      },
      initialRoute:firstTime?StartScreen.routeName: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
   );
  }
}
