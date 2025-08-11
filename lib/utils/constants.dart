import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
class FontSizes {
  static const double headingSize = 32.0;
  static const double subheadingSize = 22.0;
  static const double bodySize = 16.0;
  static const double captionSize = 13.0;
  static const double padding = 20;
}

class Fonts{
  static final headingFont = GoogleFonts.poppins();
  static final subheadingFont = GoogleFonts.raleway();
  static final bodyFont = GoogleFonts.roboto();
  static final captionFont = GoogleFonts.openSans();
}

class AllColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color mainText = Color(0xFF111827);
  static const Color secondaryText = Color(0xFF374151);
  static const Color captionText = Color(0xFF9CA3AF);
  static const Color primaryAccent = Color(0xFF3B82F6);
  static const Color secondaryAccent = Color(0xFF6366F1);
  static const Color cardBackground = Color(0xFFF9FAFB);
}

class FontStyles {
  static final heading = Fonts.headingFont.copyWith(fontSize:FontSizes.headingSize, color: AllColors.mainText, fontWeight: FontWeight.bold);
  static final subheading = Fonts.subheadingFont.copyWith(fontSize:FontSizes.subheadingSize, color: AllColors.mainText, fontWeight: FontWeight.w300);
  static final body = Fonts.bodyFont.copyWith(fontSize: FontSizes.bodySize, color: AllColors.mainText, fontWeight: FontWeight.normal);
  static final caption = Fonts.captionFont.copyWith(fontSize: FontSizes.captionSize, color: AllColors.captionText, fontWeight: FontWeight.w100);
  static final backgroundAccent = Fonts.captionFont.copyWith(fontSize: FontSizes.bodySize, color: AllColors.background, fontWeight: FontWeight.w100);




}