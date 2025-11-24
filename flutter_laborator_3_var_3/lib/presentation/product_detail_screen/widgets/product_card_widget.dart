import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../core/models/ecommerce_models.dart';
import '../../../theme/text_style_helper.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_rating_display.dart';

class ProductCardWidget extends StatelessWidget {
  final dynamic product; // Can be Product or RelatedProduct
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCardWidget({
    Key? key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRelatedProduct = product is RelatedProduct;
    final isDiscounted = isRelatedProduct ? (product as RelatedProduct).oldPrice != null : false;

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
                  imagePath: isRelatedProduct ? (product as RelatedProduct).image : (product as Product).image,
                  width: double.infinity,
                  height: 164.h,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(8.h),
                ),
                if (isRelatedProduct && (product as RelatedProduct).discount != null)
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
                        (product as RelatedProduct).discount!,
                        style: TextStyleHelper.instance.label11SemiBoldMetropolis.copyWith(color: appTheme.white_A700),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8.h,
                  right: 8.h,
                  child: CustomIconButton(
                    iconPath: ImageConstant.imgIcon,
                    onTap: onFavoriteTap,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Brand
            Text(
              isRelatedProduct ? (product as RelatedProduct).brand : (product as Product).brand,
              style: TextStyleHelper.instance.label11RegularMetropolis,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Name
            Text(
              isRelatedProduct ? (product as RelatedProduct).title : (product as Product).name,
              style: TextStyleHelper.instance.title16SemiBoldMetropolis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Rating
            CustomRatingDisplay(
              rating: isRelatedProduct ? (product as RelatedProduct).rating : (product as Product).rating,
              reviewCount: isRelatedProduct ? (product as RelatedProduct).reviewsCount : (product as Product).reviews,
            ),
            SizedBox(height: 4.h),
            // Price section
            _buildPriceSection(isRelatedProduct, isDiscounted),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(bool isRelatedProduct, bool isDiscounted) {
    if (isRelatedProduct) {
      final relatedProduct = product as RelatedProduct;
      if (isDiscounted && relatedProduct.oldPrice != null) {
        return Row(
          children: [
            Text(
              '\$${relatedProduct.oldPrice?.toStringAsFixed(0)}',
              style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                color: appTheme.gray_500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 6.h),
            Text(
              '\$${relatedProduct.price.toStringAsFixed(0)}',
              style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                color: appTheme.red_700,
              ),
            ),
          ],
        );
      }
      return Text(
        '\$${relatedProduct.price.toStringAsFixed(0)}',
        style: TextStyleHelper.instance.body14MediumMetropolis,
      );
    } else {
      final normalProduct = product as Product;
      if (isDiscounted && normalProduct.oldPrice != null) {
        return Row(
          children: [
            Text(
              '\$${normalProduct.oldPrice?.toStringAsFixed(0)}',
              style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                color: appTheme.gray_500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 6.h),
            Text(
              '\$${normalProduct.newPrice?.toStringAsFixed(0) ?? normalProduct.price?.toStringAsFixed(0)}',
              style: TextStyleHelper.instance.body14MediumMetropolis.copyWith(
                color: appTheme.red_700,
              ),
            ),
          ],
        );
      }
      return Text(
        '\$${normalProduct.price?.toStringAsFixed(0) ?? '0'}',
        style: TextStyleHelper.instance.body14MediumMetropolis,
      );
    }
  }
}