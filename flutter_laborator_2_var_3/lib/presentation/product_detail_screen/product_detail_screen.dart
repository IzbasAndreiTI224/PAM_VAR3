import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_rating_display.dart';
import './widgets/product_card_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> recommendedProducts = [
    {
      "brand": "Dorothy Perkins",
      "name": "Evening Dress",
      "price": "12\$",
      "originalPrice": "15\$",
      "discountLabel": "-20%",
      "rating": 5.0,
      "reviewCount": 10,
      "imagePath": ImageConstant.imgImage2184x148,
      "isDiscounted": true,
      "labelColor": appTheme.red_700,
    },
    {
      "brand": "Mango Boy",
      "name": "T-Shirt Sailing",
      "price": "10\$",
      "originalPrice": null,
      "discountLabel": "NEW",
      "rating": 0.0,
      "reviewCount": 0,
      "imagePath": ImageConstant.imgImage184x148,
      "isDiscounted": false,
      "labelColor": appTheme.gray_900,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray_50,
      appBar: CustomAppBar(
        title: 'Short dress',
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
            _buildImageGallery(),
            _buildProductOptions(),
            _buildProductInfo(),
            _buildProductDescription(),
            _buildDivider(),
            _buildShippingInfo(),
            _buildDivider(),
            _buildSupportInfo(),
            _buildDivider(),
            _buildRecommendationsHeader(),
            _buildRecommendationsList(),
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

  Widget _buildImageGallery() {
    return Container(
      height: 412.h,
      child: Row(
        children: [
          Expanded(
            flex: 274,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgImage412x274,
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
          Expanded(
            flex: 276,
            child: CustomImageView(
              imagePath: ImageConstant.imgImage412x276,
              height: 412.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductOptions() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 0),
      child: Row(
        children: [
          Expanded(
            child: CustomDropdown(
              hintText: 'Size',
              items: ['XS', 'S', 'M', 'L', 'XL'],
              borderColor: appTheme.deep_orange_A700,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: CustomDropdown(
              hintText: 'Color',
              items: ['Black', 'White', 'Red', 'Blue'],
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

  Widget _buildProductInfo() {
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
                Text('H&M', style: TextStyleHelper.instance.headline24SemiBoldMetropolis),
                SizedBox(height: 6.h),
                Text('Short black dress', style: TextStyleHelper.instance.label11RegularMetropolis),
                SizedBox(height: 8.h),
                CustomRatingDisplay(rating: 5.0, reviewCount: 10),
              ],
            ),
          ),
          Text('\$19.99', style: TextStyleHelper.instance.headline24SemiBoldMetropolis),
        ],
      ),
    );
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.h, 18.h, 16.h, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.',
            style: TextStyleHelper.instance.body14RegularMetropolis.copyWith(height: 1.5),
          ),
          SizedBox(height: 8.h),
          Text('Item details', style: TextStyleHelper.instance.title16RegularMetropolis),
        ],
      ),
    );
  }

  Widget _buildDivider() => Container(margin: EdgeInsets.only(top: 16.h), height: 1.h, color: appTheme.color3F9B9B);
  Widget _buildShippingInfo() => Padding(padding: EdgeInsets.fromLTRB(16.h, 14.h, 16.h, 0), child: Text('Shipping info', style: TextStyleHelper.instance.title16RegularMetropolis));
  Widget _buildSupportInfo() => Padding(padding: EdgeInsets.fromLTRB(16.h, 14.h, 16.h, 0), child: Text('Support', style: TextStyleHelper.instance.title16RegularMetropolis));

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

  Widget _buildRecommendationsList() {
    return Container(
      height: 262.h,
      margin: EdgeInsets.fromLTRB(16.h, 14.h, 0, 14.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recommendedProducts.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.h),
        itemBuilder: (context, index) {
          final product = recommendedProducts[index];
          return ProductCardWidget(
            brand: product['brand'],
            name: product['name'],
            price: product['price'],
            originalPrice: product['originalPrice'],
            discountLabel: product['discountLabel'],
            rating: product['rating'],
            reviewCount: product['reviewCount'],
            imagePath: product['imagePath'],
            isDiscounted: product['isDiscounted'],
            labelColor: product['labelColor'],
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
