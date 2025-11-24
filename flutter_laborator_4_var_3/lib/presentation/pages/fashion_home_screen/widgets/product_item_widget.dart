import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
import '../../../../../presentation/widgets/custom_image_view.dart';
import '../../../../../presentation/widgets/custom_rating_display.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductItemWidget({
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
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.h),
                      child: CustomImageView(
                        imagePath: product.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (product.isNew)
                      Positioned(
                        top: 8.h,
                        left: 8.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: appTheme.gray_900,
                            borderRadius: BorderRadius.circular(12.h),
                          ),
                          child: Text(
                            'NEW',
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
              ),
              SizedBox(height: 8.h),
              Text(
                product.brand,
                style: TextStyleHelper.instance.label11RegularMetropolis,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                product.name, // 👈 Acum este deja curățat din repository
                style: TextStyleHelper.instance.title16SemiBoldMetropolis.copyWith(
                  fontSize: 14.fSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              CustomRatingDisplay(
                rating: product.rating,
                reviewCount: product.reviews,
              ),
              SizedBox(height: 4.h),
              Text(
                '\$${product.price?.toStringAsFixed(0) ?? '0'}',
                style: TextStyleHelper.instance.body14MediumMetropolis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}