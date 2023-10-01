import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

class ThemeManager {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryTint20,
    primaryColorDark: ColorManager.primaryShade20,
    disabledColor: ColorManager.primaryTint70,
    splashColor: ColorManager.primaryTint10,
    scaffoldBackgroundColor: ColorManager.primaryTint100,
    drawerTheme: DrawerThemeData(
      backgroundColor: ColorManager.primary,
    ),
    cardTheme: CardTheme(
      color: ColorManager.primary,
      shadowColor: ColorManager.primaryShade70,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r24),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: ColorManager.primaryTint80,
      selectedColor: ColorManager.primary,
      disabledColor: ColorManager.primaryTint70,
      labelStyle: TextStyle(color: ColorManager.primaryShade100),
      brightness: Brightness.dark,
      shape: const StadiumBorder(),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.primaryShade100,
      textColor: ColorManager.primaryShade100,
      tileColor: ColorManager.primaryTint100,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryShade100,
      titleTextStyle: getBoldStyle(
        color: ColorManager.primaryTint100,
        fontSize: FontSize.s16,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.primaryTint70,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryTint20,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMediumStyle(
          color: ColorManager.primaryTint10,
          fontSize: FontSize.s14,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primary,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(ColorManager.primaryTint100),
      foregroundColor: MaterialStateProperty.all(ColorManager.primaryShade100),
      textStyle: MaterialStateProperty.all(
        getMediumStyle(
          fontSize: FontSize.s12,
          color: ColorManager.primaryShade100,
        ),
      ),
    )),
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
        color: ColorManager.primaryShade70,
        fontSize: FontSize.s24,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.primaryShade70,
        fontSize: FontSize.s20,
      ),
      displaySmall: getBoldStyle(
        color: ColorManager.primaryShade70,
        fontSize: FontSize.s18,
      ),
      headlineLarge: getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.primaryShade100,
      ),
      headlineMedium: getBoldStyle(
        fontSize: FontSize.s16,
        color: ColorManager.primaryShade100,
      ),
      headlineSmall: getBoldStyle(
        fontSize: FontSize.s14,
        color: ColorManager.primaryShade100,
      ),
      titleLarge: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s14,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getMediumStyle(
          fontSize: FontSize.s16, color: ColorManager.primaryShade70),
      bodyMedium: getMediumStyle(
          fontSize: FontSize.s14, color: ColorManager.primaryShade70),
      bodySmall: getMediumStyle(
          fontSize: FontSize.s12, color: ColorManager.primaryShade70),
      labelLarge: getRegularStyle(
          fontSize: FontSize.s16, color: ColorManager.primaryShade70),
      labelMedium: getRegularStyle(
          fontSize: FontSize.s14, color: ColorManager.primaryShade70),
      labelSmall: getRegularStyle(
          fontSize: FontSize.s12, color: ColorManager.primaryShade70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(color: ColorManager.primaryShade50),
      labelStyle: getMediumStyle(color: ColorManager.primaryShade60),
      errorStyle: getRegularStyle(color: ColorManager.error),
      fillColor: ColorManager.primaryTint90,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryTint70,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primaryTint100,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.primaryTint80,
      selectedIconTheme: IconThemeData(color: ColorManager.primary),
      unselectedIconTheme: IconThemeData(color: ColorManager.primaryTint80),
      selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: ColorManager.primary),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal, color: ColorManager.primaryTint100),
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ColorManager.primaryTint80,
        modalBackgroundColor: ColorManager.primaryTint100),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.primary,
      primaryContainer: ColorManager.primaryTint10,
      secondary: ColorManager.lightestGrey,
      secondaryContainer: ColorManager.primaryTint100,
      surface: ColorManager.primaryTint100,
      background: ColorManager.primaryTint90,
      error: ColorManager.error,
      onPrimary: ColorManager.primaryTint100,
      onSecondary: ColorManager.primaryTint100,
      onSurface: ColorManager.primaryTint60,
      onBackground: ColorManager.primaryTint60,
      onError: ColorManager.primaryTint100,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryTint20,
    primaryColorDark: ColorManager.primaryShade20,
    disabledColor: ColorManager.primaryTint70,
    splashColor: ColorManager.primaryTint10,
    scaffoldBackgroundColor: ColorManager.primaryShade70,
    drawerTheme: DrawerThemeData(
      backgroundColor: ColorManager.primaryShade10,
    ),
    cardTheme: CardTheme(
      color: ColorManager.primaryShade30,
      shadowColor: ColorManager.primaryShade70,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r24),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: ColorManager.primaryTint80,
      selectedColor: ColorManager.primary,
      disabledColor: ColorManager.primaryTint70,
      labelStyle: TextStyle(color: ColorManager.primaryShade100),
      brightness: Brightness.dark,
      shape: const StadiumBorder(),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.primaryShade100,
      textColor: ColorManager.primaryShade100,
      tileColor: ColorManager.primaryTint100,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primaryShade10,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryTint100,
      titleTextStyle: getBoldStyle(
        color: ColorManager.primaryTint100,
        fontSize: FontSize.s16,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.primaryTint70,
      buttonColor: ColorManager.primaryShade30,
      splashColor: ColorManager.primaryTint20,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMediumStyle(
          color: ColorManager.primaryShade10,
          fontSize: FontSize.s14,
        ),
        backgroundColor: ColorManager.primaryShade10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorManager.primaryTint100),
        foregroundColor:
            MaterialStateProperty.all(ColorManager.primaryShade100),
        textStyle: MaterialStateProperty.all(
          getMediumStyle(
            fontSize: FontSize.s12,
            color: ColorManager.primaryShade100,
          ),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primaryShade10,
    ),
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
        color: ColorManager.primaryTint70,
        fontSize: FontSize.s24,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.primaryTint70,
        fontSize: FontSize.s20,
      ),
      displaySmall: getBoldStyle(
        color: ColorManager.primaryTint70,
        fontSize: FontSize.s18,
      ),
      headlineLarge: getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.primaryShade100,
      ),
      headlineMedium: getBoldStyle(
        fontSize: FontSize.s16,
        color: ColorManager.primaryShade100,
      ),
      headlineSmall: getBoldStyle(
        fontSize: FontSize.s14,
        color: ColorManager.primaryShade100,
      ),
      titleLarge: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s14,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.primaryShade100,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getMediumStyle(
          fontSize: FontSize.s16, color: ColorManager.primaryTint70),
      bodyMedium: getMediumStyle(
          fontSize: FontSize.s14, color: ColorManager.primaryTint70),
      bodySmall: getMediumStyle(
          fontSize: FontSize.s12, color: ColorManager.primaryTint70),
      labelLarge: getRegularStyle(
          fontSize: FontSize.s16, color: ColorManager.primaryTint100),
      labelMedium: getRegularStyle(
          fontSize: FontSize.s14, color: ColorManager.primaryTint100),
      labelSmall: getRegularStyle(
          fontSize: FontSize.s12, color: ColorManager.primaryTint100),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(color: ColorManager.primaryTint70),
      labelStyle: getMediumStyle(color: ColorManager.primaryTint60),
      errorStyle: getRegularStyle(color: ColorManager.error),
      fillColor: ColorManager.primaryShade80,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryShade60,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primaryTint100,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.primaryTint80,
      selectedIconTheme: IconThemeData(color: ColorManager.primary),
      unselectedIconTheme: IconThemeData(color: ColorManager.primaryTint80),
      selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: ColorManager.primary),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal, color: ColorManager.primaryTint100),
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ColorManager.primaryTint80,
        modalBackgroundColor: ColorManager.primaryTint100),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.primary,
      primaryContainer: ColorManager.primaryTint10,
      secondary: ColorManager.lightestGrey,
      secondaryContainer: ColorManager.primaryTint100,
      surface: ColorManager.primaryTint100,
      background: ColorManager.primaryTint90,
      error: ColorManager.error,
      onPrimary: ColorManager.primaryTint100,
      onSecondary: ColorManager.primaryTint100,
      onSurface: ColorManager.primaryTint60,
      onBackground: ColorManager.primaryTint60,
      onError: ColorManager.primaryTint100,
    ),
  );
}

CupertinoThemeData getCupertinoApplicationTheme() {
  return CupertinoThemeData(
    primaryColor: ColorManager.primary,
    // primaryContrastingColor: ColorManager.white,
    // scaffoldBackgroundColor: ColorManager.white,
    barBackgroundColor: ColorManager.primary,
    textTheme: CupertinoTextThemeData(
      primaryColor: ColorManager.primary,
      textStyle: getRegularStyle(color: ColorManager.primary),
    ),
  );
}
