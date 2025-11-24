import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomRatingDisplay - A reusable rating display component that shows star ratings
 * with review count, supporting customizable star size, spacing, and responsive design
 */
class CustomRatingDisplay extends StatelessWidget {
  CustomRatingDisplay({
    Key? key,
    this.rating,
    this.reviewCount,
    this.starSize,
    this.spacing,
    this.margin,
    this.alignment,
  }) : super(key: key);

  /// Rating value from 0.0 to 5.0
  final double? rating;

  /// Number of reviews to display in parentheses
  final int? reviewCount;

  /// Size of individual star icons
  final double? starSize;

  /// Spacing between stars and review count text
  final double? spacing;

  /// External margin around the entire component
  final EdgeInsetsGeometry? margin;

  /// Alignment of the rating display
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final double effectiveRating = rating ?? 5.0;
    final int effectiveReviewCount = reviewCount ?? 10;
    final double effectiveStarSize = starSize ?? 14.h;
    final double effectiveSpacing = spacing ?? 2.h;

    return Container(
      margin: margin,
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildStarsRow(context, effectiveRating, effectiveStarSize),
          SizedBox(width: effectiveSpacing),
          _buildReviewCountText(context, effectiveReviewCount),
        ],
      ),
    );
  }

  /// Builds the row of star icons based on rating value
  Widget _buildStarsRow(BuildContext context, double rating, double starSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return CustomImageView(
          imagePath: ImageConstant.imgStarActivated,
          height: starSize,
          width: starSize,
        );
      }),
    );
  }

  /// Builds the review count text with consistent styling
  Widget _buildReviewCountText(BuildContext context, int reviewCount) {
    return Text(
      '($reviewCount)',
      style: TextStyleHelper.instance.label10RegularMetropolis
          .copyWith(height: 1.0),
    );
  }
}