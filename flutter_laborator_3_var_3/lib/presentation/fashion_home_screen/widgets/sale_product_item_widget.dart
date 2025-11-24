import 'package:flutter/material.dart';

import '../../../../core/app_export.dart';
import '../../../../core/models/ecommerce_models.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../../widgets/custom_rating_display.dart';

class SaleProductItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const SaleProductItemWidget({
    Key? key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 142.h,
        padding: EdgeInsets.all(4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Image + Discount + Favorite ---
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: CustomImageView(
                    imagePath: product.image,
                    width: double.infinity,
                    height: 162.h,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.discount != null)
                  Positioned(
                    top: 8.h,
                    left: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: appTheme.red_700,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        '-${product.discount}%',
                        style: TextStyleHelper.instance.label11SemiBoldMetropolis.copyWith(
                          color: appTheme.white_A700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8.h,
                  right: 8.h,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 32.h,
                      height: 32.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: BoxDecoration(
                        color: appTheme.white_A700,
                        borderRadius: BorderRadius.circular(16.h),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.black_900_14,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgIcon,
                        color: product.isFavorite ? appTheme.red_700 : appTheme.gray_500,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // --- Brand ---
            Text(
              product.brand,
              style: TextStyleHelper.instance.label11RegularMetropolis,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // --- Title ---
            Text(
              product.name,
              style: TextStyleHelper.instance.title16SemiBoldMetropolis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // --- Rating ---
            CustomRatingDisplay(
              rating: product.rating,
              reviewCount: product.reviews,
            ),
            SizedBox(height: 4.h),
            // --- Price ---
            Row(
              children: [
                if (product.oldPrice != null)
                  Text(
                    '\$${product.oldPrice?.toStringAsFixed(0)}',
                    style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                      color: appTheme.gray_500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(width: 6.h),
                Text(
                  '\$${product.newPrice?.toStringAsFixed(0) ?? product.price?.toStringAsFixed(0)}',
                  style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                    color: appTheme.red_700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}