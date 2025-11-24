import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomIconButton - A reusable icon button component with customizable styling
 *
 * Features:
 * - Configurable border radius and padding
 * - Built-in shadow effects
 * - Support for custom icons
 * - Responsive design using SizeUtils
 * - Tap handling with callback support
 *
 * @param iconPath - Path to the icon asset (SVG/PNG)
 * @param onTap - Callback function triggered on button tap
 * @param borderRadius - Border radius for button corners (default: 16)
 * @param padding - Internal padding for the button (default: 4)
 * @param backgroundColor - Background color of the button (default: white)
 * @param iconSize - Size of the icon (calculated based on padding)
 * @param margin - External margin around the button
 */
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    required this.iconPath,
    this.onTap,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.iconSize,
    this.margin,
  }) : super(key: key);

  /// Path to the icon asset
  final String iconPath;

  /// Callback function triggered when button is tapped
  final VoidCallback? onTap;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Internal padding of the button
  final double? padding;

  /// Background color of the button
  final Color? backgroundColor;

  /// Size of the icon
  final double? iconSize;

  /// External margin around the button
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final double effectiveBorderRadius = borderRadius ?? 16.h;
    final double effectivePadding = padding ?? 4.h;
    final Color effectiveBackgroundColor =
        backgroundColor ?? appTheme.whiteCustom;
    final double effectiveIconSize =
        iconSize ?? _calculateIconSize(effectivePadding);

    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(effectivePadding),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            boxShadow: [
              BoxShadow(
                color: appTheme.black_900_14,
                offset: Offset(0, 4.h),
                blurRadius: 4.h,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CustomImageView(
            imagePath: iconPath,
            height: effectiveIconSize,
            width: effectiveIconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  /// Calculate icon size based on padding to match design specifications
  double _calculateIconSize(double padding) {
    // Based on the JSON analysis: 4px padding = ~26px icon, 6px padding = ~24px icon
    if (padding >= 6.h) {
      return 24.h;
    } else {
      return 26.h;
    }
  }
}
