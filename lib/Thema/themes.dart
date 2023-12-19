import 'package:bedesten/Screens/HomeScreenFile/design_course_app_theme.dart';
import 'package:flutter/material.dart';

class Themes {
  // Light Tema
  static ThemeData get lightTheme {
    // Burada light tema için özelleştirmeler yapabilirsiniz
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: DesignCourseAppTheme.nearlyWhite,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontSize: 20.0),
        ).bodyMedium, titleTextStyle: TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontSize: 20.0),
        ).titleLarge,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      // Diğer light tema ayarları...
    );
  }

  // Dark Tema
  static ThemeData get darkTheme {
    // Burada dark tema için özelleştirmeler yapabilirsiniz
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
      hintColor: Colors.white54,

      scaffoldBackgroundColor: Color(0xFF2F2F2F),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: Colors.black), toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 20.0),
        ).bodyMedium, titleTextStyle: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 20.0),
        ).titleLarge,
      ),
      // Diğer dark tema ayarları...
    );
  }
}
