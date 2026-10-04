import 'package:flutter/material.dart';

abstract class AppTextStyles {
  // Oswald (display/headings) — use UPPERCASE in UI
  static const TextStyle headingXl = TextStyle(
    fontFamily: 'Oswald',
    fontSize: 34,
    height: 36 / 34,
    fontWeight: FontWeight.w600,
    letterSpacing: 34 * 0.01,
  );

  static const TextStyle headingLg = TextStyle(
    fontFamily: 'Oswald',
    fontSize: 26,
    height: 30 / 26,
    fontWeight: FontWeight.w600,
    letterSpacing: 26 * 0.01,
  );

  static const TextStyle headingMd = TextStyle(
    fontFamily: 'Oswald',
    fontSize: 19,
    height: 24 / 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 19 * 0.04,
  );

  // Manrope (sans/body)
  static const TextStyle bodyLg = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 15 * 0.04,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 11 * 0.08,
  );

  // JetBrains Mono (numbers, amounts, time)
  static const TextStyle amountXl = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 34,
    height: 36 / 34,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle amountMd = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle tabular = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
  );
}
