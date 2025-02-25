import 'package:event_planning_app/core/color_manager.dart';
import 'package:flutter/material.dart';

class AppStyle {

  static ThemeData lightTheme = ThemeData(

    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white, // لون خلفية منتقي الوقت
      hourMinuteTextColor: Colors.white, // لون نص الساعات والدقائق
      hourMinuteColor:ColorManager.lightPrimary,
      // Colors.grey[200], // لون خلفية حقل الساعات والدقائق
      dialHandColor: ColorManager.lightPrimary, // لون مؤشر الساعة
      dialBackgroundColor: Colors.grey[300], // لون خلفية قرص الساعة
padding: EdgeInsets.all(15)
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.lightPrimary,
      unselectedLabelColor:ColorManager.darkSecondary,
    ),
    fontFamily: "Inter",
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.lightPrimary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        selectedItemColor:   Colors.white,
        unselectedItemColor: Colors.white
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
      color: ColorManager.lightPrimary,
    ),
    textTheme: TextTheme(
        bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorManager.lightTextFieldForm),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: ColorManager.lightPrimary,
        ),
        titleSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorManager.lightSecondary),
        labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorManager.darkSecondary),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: ColorManager.background)),
    scaffoldBackgroundColor: ColorManager.background,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManager.lightSecondary),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: ColorManager.lightSecondary,
          fontSize: 22,
        )),
    colorScheme: ColorScheme.light(
        // seedColor: ColorManager.background,
        primary: ColorManager.lightPrimary,
        tertiary: ColorManager.lightTertiary,
        secondary: ColorManager.lightSecondary,
        onPrimary: ColorManager.darkSecondary,
        onSecondary: ColorManager.lightPrimary,
        onSecondaryContainer: ColorManager.lightTextFieldForm,
      onTertiaryContainer:  ColorManager.darkSecondary,
      onPrimaryFixed: ColorManager.darkSecondary,
      inversePrimary: ColorManager.lightPrimary,
      primaryContainer: ColorManager.darkSecondary,
        onPrimaryContainer: ColorManager.darkSecondary,
        onInverseSurface:  ColorManager.darkSecondary

    ),
  );

  static ThemeData darkTheme = ThemeData(
    timePickerTheme: TimePickerThemeData(
        backgroundColor: ColorManager.backgroundDark, // لون خلفية منتقي الوقت
        hourMinuteTextColor: Colors.white, // لون نص الساعات والدقائق
        hourMinuteColor:ColorManager.lightPrimary,
        // Colors.grey[200], // لون خلفية حقل الساعات والدقائق
        dialHandColor: ColorManager.lightPrimary, // لون مؤشر الساعة
        dialBackgroundColor:  Colors.black, // لون خلفية قرص الساعة
        padding: EdgeInsets.all(15)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.backgroundDark,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      selectedItemColor:   Colors.white,
      unselectedItemColor: Colors.white
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
      color: ColorManager.lightPrimary,
    ),
    fontFamily: "Inter",
    textTheme: TextTheme(
        bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorManager.darkSecondary),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: ColorManager.lightPrimary,
        ),
        titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorManager.darkSecondary),
        labelLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorManager.lightSecondary),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: ColorManager.background)),
    scaffoldBackgroundColor: ColorManager.backgroundDark,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: ColorManager.darkPrimary),
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorManager.darkPrimary,
        fontSize: 22,
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.dark(
        // seedColor: ColorManager.background,
        primary: ColorManager.darkPrimary,
        tertiary: ColorManager.darkTertiary,
        secondary: ColorManager.darkSecondary,
        onPrimary: ColorManager.lightSecondary,
        onSecondaryContainer: ColorManager.darkSecondary,
      onSecondary: ColorManager.backgroundDark,//use
        primaryContainer: ColorManager.darkSecondary,// used with unselected svg tab bar
      onTertiaryContainer:  ColorManager.darkPrimary,//use label
      onPrimaryFixed: ColorManager.darkPrimary,//use label
      inversePrimary: ColorManager.darkSecondary,// used with selected svg tab bar
onPrimaryContainer: ColorManager.backgroundDark,
        onInverseSurface:  ColorManager.backgroundDark
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.darkSecondary,
      unselectedLabelColor:ColorManager.darkSecondary,

    ),
  );
}
