import 'package:flutter/material.dart';

/// Bảng màu và theme dùng chung, theo docs/UI_SPEC.md.
abstract final class KeoColors {
  static const yellow = Color(0xFFFFB51D);
  static const blue = Color(0xFF65C9FA);
  static const beige = Color(0xFFFFF2CF);
  static const brown = Color(0xFF76401C);
  static const grass = Color(0xFFB8DC99);
  static const ink = Color(0xFF3B2518);
  static const locked = Color(0xFFD9D4CA);
  static const scrim = Color(0xC2000000);
}

ThemeData keoTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: KeoColors.yellow,
      scaffoldBackgroundColor: KeoColors.grass,
      fontFamily: 'Roboto',
    );
