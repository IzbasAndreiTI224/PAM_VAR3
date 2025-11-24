import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline34BlackMetropolis => TextStyle(
    fontSize: 34.fSize,
    fontWeight: FontWeight.w900,
    fontFamily: 'Metropolis',
    color: appTheme.white_A700,
  );

  TextStyle get headline34BoldMetropolis => TextStyle(
    fontSize: 34.fSize,
    fontWeight: FontWeight.w700,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  TextStyle get headline24SemiBoldMetropolis => TextStyle(
    fontSize: 24.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
    fontSize: 20.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );

  TextStyle get title18SemiBoldMetropolis => TextStyle(
    fontSize: 18.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  TextStyle get title16SemiBoldMetropolis => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  TextStyle get title16RegularMetropolis => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14MediumMetropolis => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  TextStyle get body14RegularMetropolis => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Metropolis',
    color: appTheme.gray_900,
  );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label11RegularMetropolis => TextStyle(
    fontSize: 11.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Metropolis',
    color: appTheme.gray_500,
  );

  TextStyle get label11SemiBoldMetropolis => TextStyle(
    fontSize: 11.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Metropolis',
    color: appTheme.white_A700,
  );

  TextStyle get label10RegularMetropolis => TextStyle(
    fontSize: 10.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Metropolis',
    color: appTheme.gray_500,
  );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get textStyle13 => TextStyle();
}
