import 'package:docare/components/colors.dart';
import 'package:docare/public_packages.dart';
import 'package:flutter/material.dart';

// class Styles {
//   static ThemeData themeData(bool isDarkTheme, BuildContext context) {
//     return ThemeData(
//       primarySwatch: Green,
//       scaffoldBackgroundColor:
//           isDarkTheme ? const Color(0xfff1b1b1b) : BackgroundGrey2,
//       primaryColor: isDarkTheme ? const Color(0xfff1b1b1b) : Colors.white,
//       backgroundColor:
//           isDarkTheme ? const Color(0xfff1b1b1b) : const Color(0xffF1F5FB),
//       indicatorColor:
//           isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
//       //buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
//       hintColor:
//           isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
//       highlightColor:
//           isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
//       hoverColor:
//           isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
//       focusColor:
//           isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
//       disabledColor: Colors.grey,
//       cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
//       canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
//       brightness: isDarkTheme ? Brightness.dark : Brightness.light,
//       buttonTheme: Theme.of(context).buttonTheme.copyWith(
//           colorScheme: isDarkTheme
//               ? const ColorScheme.dark()
//               : const ColorScheme.light()),
//       appBarTheme: const AppBarTheme(
//         elevation: 0.0,
//       ),
//       textTheme: TextTheme(
//           headline1: GoogleFonts.poppins(
//         fontSize: 14.sp,
//         color: isDarkTheme ? BackgroundGrey1 : Green,
//         fontWeight: FontWeight.w500,
//         letterSpacing: 0,
//       )),
//       // textSelectionTheme: TextSelectionThemeData(
//       //   selectionColor: isDarkTheme ? Colors.white : Colors.black,
//       // ),
//     );
//   }
// }

class MyTheme {
  static final lightTheme = ThemeData.light().copyWith(
    // primaryColor: MidGrey2,
    // primarySwatch: Green,
    scaffoldBackgroundColor: BackgroundGrey2,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: BackgroundGrey2,
      // selectedLabelStyle: GoogleFonts.poppins(
      //   fontSize: 12.sp,
      //   color: DarkGrey2,
      //   //fontWeight: FontWeight.bold,
      // ),
      // unselectedLabelStyle: GoogleFonts.poppins(
      //   fontSize: 12.sp,
      //   color: DarkGrey2,
      //   //fontWeight: FontWeight.w600,
      // ),
    ),

    colorScheme: ColorScheme.dark(
      onPrimary: DarkGrey2,
      primary: BackgroundGrey2,
      primaryContainer: BackgroundGrey1.withAlpha(120),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Green,
    scaffoldBackgroundColor: Color(0xfff242124),
    colorScheme: ColorScheme.light(
      onPrimary: BackgroundGrey1,
      primary: const Color(
        0xfff242124,
      ),
      primaryContainer: Color.fromARGB(255, 31, 31, 31),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xfff242124),
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: DarkGrey2,
        //fontWeight: FontWeight.bold,
      ),
      // unselectedLabelStyle: GoogleFonts.poppins(
      //   fontSize: 12.sp,
      //   color: DarkGrey2,
      //   //fontWeight: FontWeight.w600,
      // ),
    ),
  );
}
