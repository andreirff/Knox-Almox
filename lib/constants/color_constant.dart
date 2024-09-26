import 'package:flutter/material.dart';

// Theme
class ColorConstant {
  static const themeColor = Color(0xFF3F5185); //0xFF00006F
  static Map<int, Color> swatchColor = {
    50: themeColor.withOpacity(0.1),
    100: themeColor.withOpacity(0.2),
    200: themeColor.withOpacity(0.3),
    300: themeColor.withOpacity(0.4),
    400: themeColor.withOpacity(0.5),
    500: themeColor.withOpacity(0.6),
    600: themeColor.withOpacity(0.7),
    700: themeColor.withOpacity(0.8),
    800: themeColor.withOpacity(0.9),
    900: themeColor.withOpacity(1),
  };

  // KNOX COLORS
  static const Color colorPrimary = Color(0xFF000000);      // Color primary
  static const Color colorPrimarySoft = Color(0xFFEAEAF2);  // Color primarySoft
  static const Color colorSecondary = Color(0xFF222222);    // Color secondary

  // KNOX BODY
  static const Color colorBody = Color(0xFFFFFFFF);
  static const Color colorInputForm = Color(0xFFFFFFFF);

  // BORDER COLORS
  static const Color colorBorder = Color(0xFFD3D3E4);       // Color border

  // BUTTONS COLORS
  static const Color colorButtomBlack = Color(0xFF000000);
  static const Color colorButtonGray = Color(0xFF222222);
  static const Color colorButtomWhite = Color(0xFFFFFFFF);

  // TEXT COLORS
  static const Color colorTextBlack = Color(0xFF000000);
  static const Color colorTextGray = Color(0xFF222222);
  static const Color colorTextWhite = Color(0xFFFFFFFF);
  static const Color colorTextInputForm = Color(0xFF448AFF);

  // ALERTS COLORS
  static const Color colorError = Color(0xFFD00E0E);
  static const Color colorSuccess = Color(0xFF16AE26);
  static const Color colorWarning = Color(0xFFEB8600);

}