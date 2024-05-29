import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  headlineSmall: GoogleFonts.sourceSerif4(
    fontSize: 25,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: GoogleFonts.sourceSerif4(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  ),
  headlineLarge: GoogleFonts.poppins(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  ),
);

class AppColors {
  static Color beige = const Color(0XCDBDB07C);
  static Color black = Colors.black87;
}

List<Color> boxColors = const [
  Color(0xff64483c),
  Color(0xffa8704e),
  Color(0xffbf875d),
  Color(0xffd8aa84),
  Color(0xffc5a08a),
  Color(0xffdbc5ae),
  Color(0xfffad5b2),
  Color(0xfffee6c4)
];

Color log1 = const Color(0XCDBDB07C);
Color log2 = const Color(0XCD40401C);
Color log3 = const Color(0XCDF4EEE3);
Color wlc1 = const Color(0XCD77763E);
Color wlc2 = const Color(0XCDF4EEE3);
