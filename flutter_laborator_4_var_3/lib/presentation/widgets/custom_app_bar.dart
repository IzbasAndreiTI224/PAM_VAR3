import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'custom_image_view.dart';

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

  final String? title;
  final String? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final double? height;
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