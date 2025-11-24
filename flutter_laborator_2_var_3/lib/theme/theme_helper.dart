import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get white_A700 => Color(0xFFFFFFFF);
  Color get gray_900 => Color(0xFF222222);
  Color get gray_500 => Color(0xFF9B9B9B);
  Color get black_900_14 => Color(0x14000000);
  Color get red_700 => Color(0xFFDB3022);
  Color get orange_300 => Color(0xFFFFBA48);
  Color get gray_50 => Color(0xFFF9F9F9);
  Color get deep_orange_A700 => Color(0xFFF01F0E);
  Color get red_800_3f => Color(0x3FD32525);

  // Additional Colors
  Color get transparentCustom => Colors.transparent;
  Color get whiteCustom => Colors.white;
  Color get redCustom => Colors.red;
  Color get greyCustom => Colors.grey;
  Color get color3F9B9B => Color(0x3F9B9B9B);
  Color get color253FD3 => Color(0x253FD325);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
