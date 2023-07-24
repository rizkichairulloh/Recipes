import 'package:flutter/material.dart';

class ColorApp {
  static var main = HexColor.fromHex('#F87C57');
  static var fontWhite = Colors.white;
  static var fontMain = HexColor.fromHex('#F87C57');
  static var footerAppbar = HexColor.fromHex('#232323');
  static var mainBlue = HexColor.fromHex('#092336');
  static var mainBlueNew = HexColor.fromHex('#3781D2');
  static var colorText = HexColor.fromHex('#4E4E4E');
  static var colorServiceTalent = HexColor.fromHex('#4D898989');
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Color kColorRed = const Color(0xFFFF3860);
Color kColorGreen = const Color(0xFF00D1B2);
Color kColorBlue = const Color(0xFF2948FF);
Color kColorYellow = const Color(0xFFF9C804);
Color kColorBlack = const Color(0xFF242424);
Color kColorGrey1 = const Color(0xFF4A4A4A);
Color kColorGrey2 = const Color(0xFFB5B5B5);
Color kColorGrey3 = const Color(0xFFDBDBDB);
Color kColorGrey4 = const Color(0xFFF5F5F5);
Color kColorGrey5 = const Color(0xFFFAFAFA);
Color kColorWhite = const Color(0xFFFFFFFF);
Color kColorOrange = const Color(0xFFFF7A58);
Color kColorSky = const Color(0xFF2B8BFD);
Color kColorOrange16 = const Color(0xFFFFEAE4);
Color kColorSky16 = const Color(0xFFDDECFF);