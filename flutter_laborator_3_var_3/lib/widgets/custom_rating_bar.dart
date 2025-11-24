import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomRatingBar - A flexible star rating component that supports both display and interactive modes
 * with customizable styling, star count, and rating values including decimal ratings
 *
 * @param rating - Current rating value (0.0 to maxRating)
 * @param maxRating - Maximum rating value (number of stars)
 * @param totalRatings - Number of ratings for display count
 * @param starSize - Size of each star icon
 * @param spacing - Space between stars and text
 * @param isReadOnly - Whether the rating can be changed by user interaction
 * @param onRatingChanged - Callback function when rating is changed
 * @param showRatingCount - Whether to show the rating count text
 * @param activeStarPath - Path to active star image
 * @param inactiveStarPath - Path to inactive star image
 * @param margin - Margin around the entire rating bar
 */
class CustomRatingBar extends StatelessWidget {
  final double? rating;
  final int? maxRating;
  final int? totalRatings;
  final double? starSize;
  final double? spacing;
  final bool? isReadOnly;
  final Function(double)? onRatingChanged;
  final bool? showRatingCount;
  final String? activeStarPath;
  final String? inactiveStarPath;
  final EdgeInsetsGeometry? margin;

  const CustomRatingBar({
    Key? key,
    this.rating,
    this.maxRating,
    this.totalRatings,
    this.starSize,
    this.spacing,
    this.isReadOnly,
    this.onRatingChanged,
    this.showRatingCount,
    this.activeStarPath,
    this.inactiveStarPath,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double currentRating = rating ?? 0.0;
    final int maxStars = maxRating ?? 5;
    final int ratingsCount = totalRatings ?? 0;
    final double starIconSize = starSize ?? 14.h;
    final double itemSpacing = spacing ?? 1.h;
    final bool readOnly = isReadOnly ?? true;
    final bool displayRatingCount = showRatingCount ?? true;
    final String activeStar =
        activeStarPath ?? 'assets/images/img_star_active.svg';
    final String inactiveStar =
        inactiveStarPath ?? 'assets/images/img_star_inactive.svg';

    return Container(
      margin: margin ?? EdgeInsets.only(top: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(maxStars, (index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index < maxStars - 1 ? itemSpacing : 0),
              child: GestureDetector(
                onTap:
                readOnly ? null : () => _handleStarTap(context, index + 1),
                child: _buildStar(index, currentRating, starIconSize,
                    activeStar, inactiveStar),
              ),
            );
          }),
          if (displayRatingCount) ...[
            SizedBox(width: 2.h),
            Text(
              '($ratingsCount)',
              style: TextStyleHelper.instance.label10RegularMetropolis
                  .copyWith(height: 1.0),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStar(int index, double currentRating, double starSize,
      String activeStar, String inactiveStar) {
    final bool isActive = index < currentRating.floor();
    final bool isHalfActive =
        index == currentRating.floor() && currentRating % 1 != 0;

    if (isHalfActive) {
      return Stack(
        children: [
          CustomImageView(
            imagePath: inactiveStar,
            height: starSize,
            width: starSize,
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: currentRating % 1,
              child: CustomImageView(
                imagePath: activeStar,
                height: starSize,
                width: starSize,
              ),
            ),
          ),
        ],
      );
    }

    return CustomImageView(
      imagePath: isActive ? activeStar : inactiveStar,
      height: starSize,
      width: starSize,
    );
  }

  void _handleStarTap(BuildContext context, int starIndex) {
    if (onRatingChanged != null) {
      onRatingChanged!(starIndex.toDouble());
    }
  }
}