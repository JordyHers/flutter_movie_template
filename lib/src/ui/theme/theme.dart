import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Color mainColor = const Color(0xFF696CFF);
Color secondColor = const Color(0xFF25245F);
Color backgroundButtonColorAdd = const Color(0xFF1E1E1E);
Color backgroundButtonColorRemove = const Color(0xFFFFBBBF);
Color inactiveColor = const Color(0xFFD7E1EA);
Color textColor = const Color(0xFF2C3F58);
Color subtitleColor = const Color(0xFF78C838F);
Color titleColor = const Color(0xFF343F53);


///
///This Function creates a material color from HEX color value
///To create a custom theme and a Primary swatch a custom color is entered
///in the function.
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class AppTheme {
   const AppTheme();

  static  ThemeData appTheme = ThemeData(
      backgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      primarySwatch: buildMaterialColor(secondColor),
      brightness: Brightness.light,
      textTheme: TextTheme(bodyText1: GoogleFonts.inter(color: titleColor,fontSize: 18),caption: GoogleFonts.inter(color: subtitleColor,fontSize: 12),
      bodyText2: GoogleFonts.inter(fontSize: 16,color: titleColor,fontWeight: FontWeight.w700,),),
      iconTheme:  IconThemeData(color: textColor),
      bottomAppBarColor: Colors.white,
      dividerColor: Colors.black.withOpacity(0.7),
      primaryTextTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black))
  );
}