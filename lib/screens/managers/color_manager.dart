import 'package:flutter/material.dart';

class ColorManager {
// // Light Theme Colors
//   static Color primary = HexColor.fromHex("#ffc107");
//   static Color primaryTint10 = HexColor.fromHex("#ffc720");
//   static Color primaryTint20 = HexColor.fromHex("#ffcd39");
//   static Color primaryTint30 = HexColor.fromHex("#ffd451");
//   static Color primaryTint40 = HexColor.fromHex("#ffda6a");
//   static Color primaryTint50 = HexColor.fromHex("#ffe083");
//   static Color primaryTint60 = HexColor.fromHex("#ffe69c");
//   static Color primaryTint70 = HexColor.fromHex("#ffecb5");
//   static Color primaryTint80 = HexColor.fromHex("#fff3cd");
//   static Color primaryTint90 = HexColor.fromHex("#fff9e6");
//   static Color primaryTint100 = HexColor.fromHex("#ffffff");

//   // Dark Theme Colors
//   static Color primaryShade10 = HexColor.fromHex("#e6ae06");
//   static Color primaryShade20 = HexColor.fromHex("#cc9a06");
//   static Color primaryShade30 = HexColor.fromHex("#b38705");
//   static Color primaryShade40 = HexColor.fromHex("#997404");
//   static Color primaryShade50 = HexColor.fromHex("#806104");
//   static Color primaryShade60 = HexColor.fromHex("#664d03");
//   static Color primaryShade70 = HexColor.fromHex("#4c3a02");
//   static Color primaryShade80 = HexColor.fromHex("#332701");
//   static Color primaryShade90 = HexColor.fromHex("#191301");
//   static Color primaryShade100 = HexColor.fromHex("#000000");

// Light Theme Colors
  static Color primary = HexColor.fromHex("#ffd740");
  static Color primaryTint10 = HexColor.fromHex("#ffdb53");
  static Color primaryTint20 = HexColor.fromHex("#ffdf66");
  static Color primaryTint30 = HexColor.fromHex("#ffe379");
  static Color primaryTint40 = HexColor.fromHex("#ffe78c");
  static Color primaryTint50 = HexColor.fromHex("#ffeba0");
  static Color primaryTint60 = HexColor.fromHex("#ffefb3");
  static Color primaryTint70 = HexColor.fromHex("#fff3c6");
  static Color primaryTint80 = HexColor.fromHex("#fff7d9");
  static Color primaryTint90 = HexColor.fromHex("#fffbec");
  static Color primaryTint100 = HexColor.fromHex("#ffffff");

  // Dark Theme Colors
  static Color primaryShade10 = HexColor.fromHex("#e6c23a");
  static Color primaryShade20 = HexColor.fromHex("#ccac33");
  static Color primaryShade30 = HexColor.fromHex("#b3972d");
  static Color primaryShade40 = HexColor.fromHex("#998126");
  static Color primaryShade50 = HexColor.fromHex("#806c20");
  static Color primaryShade60 = HexColor.fromHex("#66561a");
  static Color primaryShade70 = HexColor.fromHex("#4c4013");
  static Color primaryShade80 = HexColor.fromHex("#332b0d");
  static Color primaryShade90 = HexColor.fromHex("#191506");
  static Color primaryShade100 = HexColor.fromHex("#000000");

  // Shared Colors
  static Color purple = HexColor.fromHex("#FFAA0BAD");
  static Color lighterGrey = HexColor.fromHex("#CFCFCF");
  static Color lightestGrey = HexColor.fromHex("#FFDADADA");
  static Color green = HexColor.fromHex("#FF008E0E");
  static Color yellow = HexColor.fromHex("#FFD0B60F");
  static Color error = HexColor.fromHex("#e61f34"); // red color

  // Opacity Colors
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color primaryColorWithOpacity = Color.fromARGB(204, 229, 99, 99);
  static Color blackWithOpacity = Color.fromARGB(204, 0, 0, 0);
  static Color transparent = Color.fromARGB(0, 0, 0, 0);
  static Color blackWithLowOpacity = Color.fromARGB(100, 0, 0, 0);
  static Color whiteWithOpacity = Color.fromARGB(204, 255, 255, 255);
  static Color greyWithOpacity = Color.fromARGB(204, 70, 70, 70);
  static Color grey2WithOpacity = Color.fromARGB(204, 79, 79, 79);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
