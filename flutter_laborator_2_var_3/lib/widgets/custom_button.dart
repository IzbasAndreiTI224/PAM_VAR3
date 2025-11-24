import 'package:flutter/material.dart';

import '../core/app_export.dart';

/**
 * CustomButton - A flexible and reusable button component
 *
 * Supports multiple button variants with customizable styling including:
 * - Text content and styling
 * - Background colors and gradients
 * - Border radius and styling
 * - Padding and dimensions
 * - Shadow effects
 * - Press states and callbacks
 *
 * @param text - The button text content
 * @param onPressed - Callback function when button is pressed
 * @param buttonStyle - Custom button styling variant
 * @param buttonTextStyle - Custom text styling variant
 * @param isDisabled - Whether the button is disabled
 * @param height - Custom button height
 * @param width - Custom button width
 * @param margin - External margin around the button
 * @param alignment - Button alignment within parent
 */
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.text,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.height,
    this.width,
    this.margin,
    this.alignment,
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final CustomButtonStyle? buttonStyle;
  final CustomButtonTextStyle? buttonTextStyle;
  final bool? isDisabled;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: buildButtonWidget,
    )
        : buildButtonWidget;
  }

  Widget get buildButtonWidget => Container(
    height: height ?? 48.h,
    width: width ?? double.maxFinite,
    margin: margin,
    child: ElevatedButton(
      onPressed: isDisabled == true ? null : onPressed,
      style: (buttonStyle ?? CustomButtonStyle.fillPrimary).buttonStyle,
      child: Text(
        text ?? "Button",
        style: (buttonTextStyle ?? CustomButtonTextStyle.labelMedium)
            .textStyle,
      ),
    ),
  );
}

class CustomButtonStyle {
  // Fill button styles
  static CustomButtonStyle get fillPrimary => CustomButtonStyle(
    backgroundColor: appTheme.red_700,
    borderRadius: BorderRadius.circular(24.h),
    padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 16.h),
    shadowColor: appTheme.color253FD3,
    elevation: 4.h,
  );

  static CustomButtonStyle get fillSecondary => CustomButtonStyle(
    backgroundColor: appTheme.gray_900,
    borderRadius: BorderRadius.circular(12.h),
    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 6.h),
  );

  // Outline button styles
  static CustomButtonStyle get outlinePrimary => CustomButtonStyle(
    backgroundColor: appTheme.transparentCustom,
    borderRadius: BorderRadius.circular(24.h),
    padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 16.h),
    borderSide: BorderSide(
      color: appTheme.red_700,
      width: 1.h,
    ),
  );

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final Color? shadowColor;
  final double? elevation;

  CustomButtonStyle({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.borderSide,
    this.shadowColor,
    this.elevation,
  });

  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
    backgroundColor: backgroundColor ?? Color(0xFFDB3022),
    foregroundColor: appTheme.whiteCustom,
    elevation: elevation ?? 0,
    shadowColor: shadowColor,
    padding: padding ?? EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(24.h),
      side: borderSide ?? BorderSide.none,
    ),
    minimumSize: Size(0, 0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

class CustomButtonTextStyle {
  // Text styles for different button variants
  static CustomButtonTextStyle get labelMedium => CustomButtonTextStyle(
    fontSize: 14.fSize,
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w500,
    color: appTheme.whiteCustom,
    height: 1.0,
  );

  static CustomButtonTextStyle get labelSmall => CustomButtonTextStyle(
    fontSize: 11.fSize,
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w600,
    color: appTheme.whiteCustom,
    height: 1.0,
  );

  static CustomButtonTextStyle get labelLarge => CustomButtonTextStyle(
    fontSize: 16.fSize,
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w600,
    color: appTheme.whiteCustom,
    height: 1.0,
  );

  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final double? height;

  CustomButtonTextStyle({
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.height,
  });

  TextStyle get textStyle => TextStyleHelper.instance.textStyle13
      .copyWith(color: color ?? appTheme.whiteCustom, height: height ?? 1.0);
}
