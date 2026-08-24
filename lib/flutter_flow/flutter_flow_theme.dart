import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color success10;
  late Color success15;
  late Color success30;
  late Color onSuccess;

  late Color primary5;
  late Color primary10;
  late Color primary20;
  late Color onPrimary;

  late Color warning10;
  late Color warning30;

  late Color info10;
  late Color onInfo;

  late Color fullContrast40;
  late Color onSurface;

  TextStyle get headlineLarge => GoogleFonts.inter(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: primaryText,
      );
  TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: primaryText,
      );
  TextStyle get headlineSmall => GoogleFonts.inter(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: primaryText,
      );
  TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      );
  TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      );
  TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      );
  TextStyle get labelLarge => GoogleFonts.spaceGrotesk(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: secondaryText,
      );
  TextStyle get labelMedium => GoogleFonts.spaceGrotesk(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: secondaryText,
      );
  TextStyle get labelSmall => GoogleFonts.spaceGrotesk(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: secondaryText,
      );
  TextStyle get bodyLarge => GoogleFonts.roboto(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: primaryText,
      );
  TextStyle get bodyMedium => GoogleFonts.roboto(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: primaryText,
      );
  TextStyle get bodySmall => GoogleFonts.roboto(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: secondaryText,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  LightModeTheme() {
    primary = const Color(0xFF1A237E);
    secondary = const Color(0xFF3949AB);
    tertiary = const Color(0xFF673AB7);
    alternate = const Color(0xFFE2E8F0);
    primaryText = const Color(0xFF0F172A);
    secondaryText = const Color(0xFF64748B);
    primaryBackground = const Color(0xFFF4F6F9);
    secondaryBackground = const Color(0xFFFFFFFF);
    accent1 = const Color(0xFFE0E7FF);
    accent2 = const Color(0xFFC7D2FE);
    accent3 = const Color(0xFFA5B4FC);
    accent4 = const Color(0xFF818CF8);
    success = const Color(0xFF10B981);
    warning = const Color(0xFFF59E0B);
    error = const Color(0xFFEF4444);
    info = const Color(0xFF3B82F6);

    success10 = const Color(0x1A10B981);
    success15 = const Color(0x2610B981);
    success30 = const Color(0x4D10B981);
    onSuccess = const Color(0xFF065F46);

    primary5 = const Color(0x0D1A237E);
    primary10 = const Color(0x1A1A237E);
    primary20 = const Color(0x331A237E);
    onPrimary = const Color(0xFF1A237E);

    warning10 = const Color(0x1AF59E0B);
    warning30 = const Color(0x4DF59E0B);

    info10 = const Color(0x1A3B82F6);
    onInfo = const Color(0xFF1E40AF);

    fullContrast40 = const Color(0x66000000);
    onSurface = const Color(0xFFD97706);
  }
}

extension TextStyleOverride on TextStyle {
  TextStyle override({
    TextStyle? font,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    double? letterSpacing,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return (font ?? this).copyWith(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: lineHeight ?? height,
      decoration: decoration ?? this.decoration,
    );
  }
}
