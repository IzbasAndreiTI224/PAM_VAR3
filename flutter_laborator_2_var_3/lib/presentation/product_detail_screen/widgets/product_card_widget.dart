import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';

class ProductCardWidget extends StatelessWidget {
  final String brand;
  final String name;
  final String price;
  final String? originalPrice;
  final String discountLabel;
  final double rating;
  final int reviewCount;
  final String imagePath;
  final bool isDiscounted;
  final Color labelColor;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCardWidget({
    Key? key,
    required this.brand,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.discountLabel,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
    required this.isDiscounted,
    required this.labelColor,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 148.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image + overlay
            Stack(
              children: [
                CustomImageView(
                  imagePath: imagePath,
                  width: double.infinity,
                  height: 164.h,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(8.h),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: labelColor,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Text(
                      discountLabel,
                      style: TextStyleHelper.instance.label11SemiBoldMetropolis.copyWith(color: appTheme.whiteCustom),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 36.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: _buildRatingSection()),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: CustomIconButton(
                            iconPath: ImageConstant.imgIcon,
                            onTap: onFavoriteTap,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            // Brand
            Text(
              brand,
              style: TextStyleHelper.instance.label11RegularMetropolis,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // Name
            Text(
              name,
              style: TextStyleHelper.instance.title16SemiBoldMetropolis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // Price section
            _buildPriceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        _buildStarRow(),
        SizedBox(width: 2.h),
        Text(
          '($reviewCount)',
          style: TextStyleHelper.instance.label10RegularMetropolis,
        ),
      ],
    );
  }

  Widget _buildStarRow() {
    return Row(
      children: List.generate(5, (index) {
        bool isActive = index < rating.floor();
        return Padding(
          padding: EdgeInsets.only(right: 1.h),
          child: CustomImageView(
            imagePath: isActive ? ImageConstant.imgStarActive : ImageConstant.imgStarInactive,
            width: 14.h,
            height: 14.h,
          ),
        );
      }),
    );
  }

  Widget _buildPriceSection() {
    if (isDiscounted && originalPrice != null) {
      return Row(
        children: [
          Stack(
            children: [
              Text(
                originalPrice!,
                style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(color: appTheme.gray_500),
              ),
              Positioned(
                top: 8.h,
                left: 0,
                right: 0,
                child: Container(height: 1.h, color: appTheme.gray_500),
              ),
            ],
          ),
          SizedBox(width: 4.h),
          Text(
            price,
            style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(color: appTheme.red_700),
          ),
        ],
      );
    }
    return Text(
      price,
      style: TextStyleHelper.instance.body14MediumMetropolis,
    );
  }
}
