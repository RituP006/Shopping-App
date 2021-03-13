import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(20, 31, 31, 1),
    cardColor: Color.fromRGBO(20, 31, 31, 1),
    colorScheme: ColorScheme.dark(),
    primarySwatch: Colors.teal,
    accentColor: Colors.deepOrangeAccent.shade200,
    primaryColor: Color.fromRGBO(25, 230, 230, 1),
    primaryColorDark: Color.fromRGBO(0, 102, 102, 1),

    fontFamily: 'OpenSans',
    appBarTheme: AppBarTheme(
      elevation: 5,
      centerTitle: true,
    ),
    // buttonTheme: ButtonThemeData(
    //   buttonColor: Color.fromRGBO(64, 0, 128, 1),
    //   hoverColor: Color.fromRGBO(217, 179, 255, 1),
    //   disabledColor: Color.fromRGBO(179, 102, 255, 1),
    //   textTheme: ButtonTextTheme.accent,
    // ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.cyan,
    accentColor: Colors.deepOrangeAccent,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 5,
      centerTitle: true,
    ),
    fontFamily: 'OpenSans',
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
