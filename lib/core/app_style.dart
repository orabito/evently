import 'package:event_planning_app/core/color_manager.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Inter",

    textTheme: TextTheme(
      titleMedium:
      TextStyle( fontWeight:FontWeight.w700 ,
          fontSize: 20,
          color: ColorManager.lightPrimary,


      ),
      titleSmall:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,color: ColorManager.lightSecondary
      ),
        labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,color: ColorManager.darkSecondary

        )



    ),
    scaffoldBackgroundColor: ColorManager.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),

    colorScheme: ColorScheme.light(
      // seedColor: ColorManager.background,
      primary: ColorManager.lightPrimary,
      tertiary: ColorManager.lightTertiary,
      secondary: ColorManager.lightSecondary,
      onPrimary: ColorManager.darkSecondary,



    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Inter",
    textTheme: TextTheme(
      titleMedium:
      TextStyle( fontWeight:FontWeight.w700 ,
        fontSize: 20,
        color: ColorManager.lightPrimary,



      ),
        titleSmall:TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,color: ColorManager.darkSecondary
        ),
      labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,color: ColorManager.lightSecondary

      )

    ),

    scaffoldBackgroundColor: ColorManager.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.dark(
      // seedColor: ColorManager.background,
      primary: ColorManager.darkPrimary,
      tertiary: ColorManager.darkTertiary,
      secondary: ColorManager.darkSecondary,
      onPrimary: ColorManager.lightSecondary,
    ),
  );
}
