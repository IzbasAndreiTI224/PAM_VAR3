import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_export.dart';
import '../../core/bloc/ecommerce/ecommerce_bloc.dart';
import '../../core/models/ecommerce_models.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_rating_display.dart';
import './widgets/product_card_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EcommerceBloc, EcommerceState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            backgroundColor: appTheme.gray_50,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProductDetailsLoaded) {
          return _buildProductDetailScreen(context, state.productDetails);
        } else if (state is EcommerceError) {
          return Scaffold(
            backgroundColor: appTheme.gray_50,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading product details'),
                  Text(state.error),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<EcommerceBloc>().add(LoadProductDetails());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // If we don't have product details loaded, load them
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<EcommerceBloc>().add(LoadProductDetails());
          });

          return Scaffold(
            backgroundColor: appTheme.gray_50,
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildProductDetailScreen(BuildContext context, ProductDetails productDetails) {
    final product = productDetails.product;
    final relatedProducts = productDetails.relatedProducts;

    return Scaffold(
      backgroundColor: appTheme.gray_50,
      appBar: CustomAppBar(
        title: product.title,
        leadingIcon: ImageConstant.imgArrowLeft,
        onLeadingPressed: () => Navigator.pop(context),
        actions: [
          CustomAppBar.buildActionButton(
            iconPath: ImageConstant.imgBaselineShare24px,
            onPressed: _onSharePressed,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageGallery(product.colors.isNotEmpty ? product.colors.first.images : []),
            _buildProductOptions(product),
            _buildProductInfo(product),
            _buildProductDescription(product),
            _buildDivider(),
            _buildShippingInfo(product),
            _buildDivider(),
            _buildSupportInfo(product),
            _buildDivider(),
            _buildRecommendationsHeader(),
            _buildRecommendationsList(relatedProducts),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.h),
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          boxShadow: [BoxShadow(color: appTheme.black_900_14, blurRadius: 8.h, offset: Offset(0, -4))],
        ),
        child: CustomButton(
          text: "ADD TO CART",
          onPressed: _onAddToCart,
          buttonStyle: CustomButtonStyle.fillPrimary,
          buttonTextStyle: CustomButtonTextStyle.labelMedium,
        ),
      ),
    );
  }

  Widget _buildImageGallery(List<String> images) {
    return Container(
      height: 412.h,
      child: Row(
        children: [
          if (images.isNotEmpty) ...[
            Expanded(
              flex: 274,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomImageView(
                      imagePath: images[0],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 124.h,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray_900,
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.h),
          ],
          if (images.length > 1)
            Expanded(
              flex: 276,
              child: CustomImageView(
                imagePath: images[1],
                height: 412.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductOptions(ProductDetail product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 0),
      child: Row(
        children: [
          Expanded(
            child: CustomDropdown(
              hintText: 'Size',
              items: product.sizes,
              borderColor: appTheme.deep_orange_A700,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: CustomDropdown(
              hintText: 'Color',
              items: product.colors.map((color) => color.name).toList(),
              borderColor: appTheme.gray_500,
            ),
          ),
          SizedBox(width: 16.h),
          CustomIconButton(
            iconPath: ImageConstant.imgIcon,
            onTap: _onFavoritePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductDetail product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.h, 20.h, 16.h, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(product.brand, style: TextStyleHelper.instance.headline24SemiBoldMetropolis),
                SizedBox(height: 6.h),
                Text(product.title, style: TextStyleHelper.instance.label11RegularMetropolis),
                SizedBox(height: 8.h),
                CustomRatingDisplay(rating: product.rating, reviewCount: product.reviewsCount),
              ],
            ),
          ),
          Text('\$${product.price.toStringAsFixed(2)}', style: TextStyleHelper.instance.headline24SemiBoldMetropolis),
        ],
      ),
    );
  }

  Widget _buildProductDescription(ProductDetail product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.h, 18.h, 16.h, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            style: TextStyleHelper.instance.body14RegularMetropolis.copyWith(height: 1.5),
          ),
          SizedBox(height: 8.h),
          Text('Item details', style: TextStyleHelper.instance.title16RegularMetropolis),
        ],
      ),
    );
  }

  Widget _buildDivider() => Container(margin: EdgeInsets.only(top: 16.h), height: 1.h, color: appTheme.color3F9B9B);

  Widget _buildShippingInfo(ProductDetail product) => Padding(
      padding: EdgeInsets.fromLTRB(16.h, 14.h, 16.h, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping info', style: TextStyleHelper.instance.title16RegularMetropolis),
          SizedBox(height: 8.h),
          Text(product.shippingInfo.delivery, style: TextStyleHelper.instance.body14RegularMetropolis),
          SizedBox(height: 4.h),
          Text(product.shippingInfo.returns, style: TextStyleHelper.instance.body14RegularMetropolis),
        ],
      )
  );

  Widget _buildSupportInfo(ProductDetail product) => Padding(
      padding: EdgeInsets.fromLTRB(16.h, 14.h, 16.h, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Support', style: TextStyleHelper.instance.title16RegularMetropolis),
          SizedBox(height: 8.h),
          Text('Email: ${product.support.contactEmail}', style: TextStyleHelper.instance.body14RegularMetropolis),
          SizedBox(height: 4.h),
          Text('FAQ: ${product.support.faqUrl}', style: TextStyleHelper.instance.body14RegularMetropolis),
        ],
      )
  );

  Widget _buildRecommendationsHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.h, 22.h, 14.h, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('You can also like this', style: TextStyleHelper.instance.title18SemiBoldMetropolis),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text('12 items', style: TextStyleHelper.instance.label11RegularMetropolis),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsList(List<RelatedProduct> relatedProducts) {
    return Container(
      height: 262.h,
      margin: EdgeInsets.fromLTRB(16.h, 14.h, 0, 14.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: relatedProducts.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.h),
        itemBuilder: (context, index) {
          final product = relatedProducts[index];
          return ProductCardWidget(
            product: product,
            onTap: _onProductTap,
            onFavoriteTap: _onFavoritePressed,
          );
        },
      ),
    );
  }

  void _onSharePressed() => print('Share pressed');
  void _onFavoritePressed() => print('Favorite pressed');
  void _onAddToCart() => print('Add to cart pressed');
  void _onProductTap() => print('Product tapped');
}