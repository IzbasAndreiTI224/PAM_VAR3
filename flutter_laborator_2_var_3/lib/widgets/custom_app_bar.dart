import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomAppBar - A reusable and customizable AppBar component
 *
 * Features:
 * - Customizable title text with styling
 * - Optional leading icon with tap callback
 * - Multiple action buttons support
 * - Configurable background color and elevation
 * - Responsive design with SizeUtils
 * - Shadow effect support
 *
 * @param title - The title text to display in the center
 * @param leadingIcon - Path to the leading icon (usually back arrow)
 * @param onLeadingPressed - Callback when leading icon is tapped
 * @param actions - List of action widgets to display on the right
 * @param backgroundColor - Background color of the AppBar
 * @param elevation - Shadow elevation of the AppBar
 * @param height - Custom height of the AppBar
 * @param titleStyle - Custom text style for the title
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.height,
    this.titleStyle,
  }) : super(key: key);

  /// The title text to display in the center of the AppBar
  final String? title;

  /// Path to the leading icon image (SVG/PNG)
  final String? leadingIcon;

  /// Callback function when the leading icon is pressed
  final VoidCallback? onLeadingPressed;

  /// List of action widgets to display on the right side
  final List<Widget>? actions;

  /// Background color of the AppBar
  final Color? backgroundColor;

  /// Shadow elevation of the AppBar
  final double? elevation;

  /// Custom height of the AppBar
  final double? height;

  /// Custom text style for the title
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Color(0xFFF9F9F9),
      elevation: elevation ?? 4.0,
      shadowColor: appTheme.black_900_14,
      leading: leadingIcon != null
          ? Padding(
        padding: EdgeInsets.all(8.h),
        child: IconButton(
          onPressed: onLeadingPressed ?? () => Navigator.pop(context),
          icon: CustomImageView(
            imagePath: leadingIcon!,
            height: 24.h,
            width: 24.h,
          ),
          padding: EdgeInsets.zero,
        ),
      )
          : null,
      title: title != null
          ? Text(
        title!,
        style: titleStyle ??
            TextStyleHelper.instance.title18SemiBoldMetropolis,
      )
          : null,
      centerTitle: true,
      actions: actions != null
          ? [
        ...actions!,
        SizedBox(width: 8.h),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  /// Helper method to create action button
  static Widget buildActionButton({
    required String iconPath,
    VoidCallback? onPressed,
    double? size,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: IconButton(
        onPressed: onPressed,
        icon: CustomImageView(
          imagePath: iconPath,
          height: size ?? 24.h,
          width: size ?? 24.h,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
