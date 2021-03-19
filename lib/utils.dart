import 'package:flutter/material.dart';

const MaterialColor whiteSwatch = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

Color convertToHex(String color) {
  color = color.replaceAll("#", "");
  Color convertedValue;
  if (color.length == 6) {
    convertedValue = Color(int.parse("0xFF" + color));
  } else if (color.length == 8) {
    convertedValue = Color(int.parse("0x" + color));
  }
  return convertedValue;
}
