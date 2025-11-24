import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

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

  final double? rating;
  final int? reviewCount;
  final double? starSize;
  final double? spacing;
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final double effectiveRating = rating ?? 0.0;
    final int effectiveReviewCount = reviewCount ?? 0;
    final double effectiveStarSize = starSize ?? 14.h;
    final double effectiveSpacing = spacing ?? 2.h;

    return Container(
      margin: margin,
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStarsRow(context, effectiveRating, effectiveStarSize),
          SizedBox(width: effectiveSpacing),
          _buildReviewCountText(context, effectiveReviewCount),
        ],
      ),
    );
  }

  Widget _buildStarsRow(BuildContext context, double rating, double starSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        bool isActive = index < rating.floor();
        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? 2.h : 0),
          child: CustomImageView(
            imagePath: isActive ? ImageConstant.imgStarActivated : ImageConstant.imgStarActivated, // Use same icon but with different color
            height: starSize,
            width: starSize,
            color: isActive ? appTheme.orange_300 : appTheme.gray_500,
          ),
        );
      }),
    );
  }

  Widget _buildReviewCountText(BuildContext context, int reviewCount) {
    return Text(
      '($reviewCount)',
      style: TextStyleHelper.instance.label10RegularMetropolis.copyWith(height: 1.0),
    );
  }
}