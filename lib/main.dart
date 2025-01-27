import 'package:event_planning_app/core/app_style.dart';

import 'package:event_planning_app/ui/start_screen/screen/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppStyle.lightTheme,

        darkTheme:AppStyle.lightTheme,

    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    routes: {
    StartScreen.routeName:(_)=>StartScreen(),

    },

    initialRoute: StartScreen.routeName,


    );
    }
}

