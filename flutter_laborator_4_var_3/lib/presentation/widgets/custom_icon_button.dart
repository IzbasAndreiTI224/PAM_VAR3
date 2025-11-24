import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'custom_image_view.dart';

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

  final String iconPath;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? padding;
  final Color? backgroundColor;
  final double? iconSize;
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

  double _calculateIconSize(double padding) {
    if (padding >= 6.h) {
      return 24.h;
    } else {
      return 26.h;
    }
  }
}
