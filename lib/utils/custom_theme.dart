import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ThemeData customLightTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(37, 112, 252, 1)),
      errorColor: Colors.red,
      platform: defaultTargetPlatform,
      primaryColor: Colors.white,
      primaryIconTheme: const IconThemeData(color: Colors.black),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(37, 112, 252, 1)),
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.light,
      // fontFamily: GoogleFonts.montserrat().fontFamily,
      secondaryHeaderColor: const Color.fromRGBO(37, 112, 252, 1),
      cardColor: const Color.fromRGBO(239, 242, 248, 1),
      iconTheme: const IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black.withOpacity(.5),
      ),
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyText1: const TextStyle(color: Colors.black, fontSize: 16),
            bodyText2: const TextStyle(color: Colors.black, fontSize: 14),
            caption: const TextStyle(color: Colors.black, fontSize: 12),
            headline1: const TextStyle(color: Colors.black, fontSize: 96),
            headline2: const TextStyle(color: Colors.black, fontSize: 60),
            headline3: const TextStyle(color: Colors.black, fontSize: 48),
            headline4: const TextStyle(color: Colors.black, fontSize: 34),
            headline5: const TextStyle(color: Colors.black, fontSize: 24),
            headline6: const TextStyle(color: Colors.black, fontSize: 20),
            subtitle1: const TextStyle(color: Colors.black, fontSize: 16),
            subtitle2: const TextStyle(color: Colors.black, fontSize: 14),
            overline: const TextStyle(color: Colors.black, fontSize: 10),
            button: const TextStyle(color: Colors.black, fontSize: 16),
          ),
      dividerColor: Colors.grey);
}

ThemeData customDarkTheme(
  BuildContext context,
) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(105, 73, 199, 1)),
      errorColor: const Color(0xFFCF6679),
      primaryColor: Colors.black,
      primaryIconTheme: const IconThemeData(color: Colors.grey),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(31, 31, 31, 1)),
      platform: defaultTargetPlatform,
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.dark,
      secondaryHeaderColor: const Color.fromRGBO(31, 31, 50, 1),
      // fontFamily: GoogleFonts.montserrat().fontFamily,
      cardColor: const Color.fromRGBO(31, 31, 31, 1),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white.withOpacity(.7),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color:Colors.black
      ),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyText1: const TextStyle(color: Colors.white, fontSize: 16),
            bodyText2: const TextStyle(color: Colors.white, fontSize: 14),
            caption: const TextStyle(color: Colors.white, fontSize: 12),
            headline1: const TextStyle(color: Colors.white, fontSize: 96),
            headline2: const TextStyle(color: Colors.white, fontSize: 60),
            headline3: const TextStyle(color: Colors.white, fontSize: 48),
            headline4: const TextStyle(color: Colors.white, fontSize: 34),
            headline5: const TextStyle(color: Colors.white, fontSize: 24),
            headline6: const TextStyle(color: Colors.white, fontSize: 20),
            subtitle1: const TextStyle(color: Colors.white, fontSize: 16),
            subtitle2: const TextStyle(color: Colors.white, fontSize: 14),
            overline: const TextStyle(color: Colors.white, fontSize: 10),
            button: const TextStyle(color: Colors.white, fontSize: 16),
          ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white.withOpacity(.6));
}
