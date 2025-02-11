import 'package:flutter/material.dart';

class LightColors {
  static final Color white = HexColor.fromHex("#FFFFFF");
  static final Color white2 = HexColor.fromHex("#E0E0E0");
  static final Color black = HexColor.fromHex("#121212");
  static final Color brandGrey = HexColor.fromHex("#F2F2F2");
  static final Color titleBlack = HexColor.fromHex("#525252");
  static final Color yellow = HexColor.fromHex("#F6C018");
  static final Color lightYellow = HexColor.fromHex("#F7C04A");
  static final Color grey = HexColor.fromHex("#E0E0E0");
  static final Color darkGrey = HexColor.fromHex("707070");
  static final Color indicatorGrey = HexColor.fromHex("ABABAB");
  static final Color blue = HexColor.fromHex("#3E468F");
}

class DarkColors {
  static final Color white = HexColor.fromHex("#121212");
  static final Color white2 = HexColor.fromHex("#E8E8E8");
  static final Color black = HexColor.fromHex("#FFFFFF");
  static final Color brandGrey = HexColor.fromHex("#F2F2F2");
  static final Color titleBlack = HexColor.fromHex("#525252");
  static final Color yellow = HexColor.fromHex("#F6C018");
  static final Color lightYellow = HexColor.fromHex("#F7C04A");
  static final Color grey = HexColor.fromHex("#E0E0E0");
  static final Color darkGrey = HexColor.fromHex("707070");
  static final Color indicatorGrey = HexColor.fromHex("ABABAB");
  static final Color blue = HexColor.fromHex("#3E468F");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
