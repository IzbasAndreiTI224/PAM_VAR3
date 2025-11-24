import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_rating_display.dart';

class SaleProductItemWidget extends StatelessWidget {
  final Map<String, dynamic> productData;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const SaleProductItemWidget({
    Key? key,
    required this.productData,
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
            // --- Image + Discount + Favorite + Rating ---
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: CustomImageView(
                    imagePath: productData['imagePath'],
                    width: double.infinity,
                    height: 162.h,
                    fit: BoxFit.cover,
                  ),
                ),
                if ((productData['discount'] ?? '').isNotEmpty)
                  Positioned(
                    top: 6.h,
                    left: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: appTheme.red_700,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        productData['discount']!,
                        style: TextStyleHelper.instance.label11SemiBoldMetropolis,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 4.h,
                  right: 0,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 32.h,
                      height: 32.h,
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        color: appTheme.white_A700,
                        borderRadius: BorderRadius.circular(16.h),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.black_900_14,
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            // --- Brand ---
            Text(
              productData['brand'] ?? '',
              style: TextStyleHelper.instance.label11RegularMetropolis,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // --- Title ---
            Text(
              productData['title'] ?? '',
              style: TextStyleHelper.instance.title16SemiBoldMetropolis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            // --- Rating ---
            CustomRatingDisplay(
              rating: productData['rating'] ?? 0.0,
              reviewCount: productData['reviewCount'] ?? 0,
            ),
            SizedBox(height: 2.h),
            // --- Price ---
            Row(
              children: [
                if ((productData['originalPrice'] ?? '').isNotEmpty)
                  Text(
                    productData['originalPrice']!,
                    style: TextStyleHelper.instance.body14MediumMetropolis
                        .copyWith(color: appTheme.gray_500),
                  ),
                SizedBox(width: 4.h),
                Text(
                  productData['salePrice'] ?? '',
                  style: TextStyleHelper.instance.body14MediumMetropolis
                      .copyWith(color: appTheme.red_700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
