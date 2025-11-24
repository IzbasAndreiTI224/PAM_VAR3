import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/product_item_widget.dart';
import './widgets/sale_product_item_widget.dart';

class FashionHomeScreen extends StatelessWidget {
  FashionHomeScreen({Key? key}) : super(key: key);

  // Sample data for new products
  final List<Map<String, dynamic>> newProducts = [
    {
      "imagePath": ImageConstant.imgImage162x140,
      "brand": "OVS",
      "title": "Blouse",
      "price": "30\$",
      "rating": 0.0,
      "reviewCount": 0,
      "hasNewTag": true,
    },
    {
      "imagePath": ImageConstant.imgImage1,
      "brand": "Mango Boy",
      "title": "T-Shirt Sailing",
      "price": "10\$",
      "rating": 0.0,
      "reviewCount": 0,
      "hasNewTag": true,
    },
    {
      "imagePath": ImageConstant.imgImage2,
      "brand": "Cool",
      "title": "Jeans",
      "price": "45\$",
      "rating": 0.0,
      "reviewCount": 0,
      "hasNewTag": true,
    },
  ];

  // Sample data for sale products
  final List<Map<String, dynamic>> saleProducts = [
    {
      "imagePath": ImageConstant.imgImage2162x140,
      "brand": "Dorothy Perkins",
      "title": "Evening Dress",
      "originalPrice": "15\$",
      "salePrice": "12\$",
      "discount": "-20%",
      "rating": 0.0,
      "reviewCount": 10,
    },
    {
      "imagePath": ImageConstant.imgImage4,
      "brand": "Sitlly",
      "title": "Sport Dress",
      "originalPrice": "22\$",
      "salePrice": "19\$",
      "discount": "-15%",
      "rating": 0.0,
      "reviewCount": 10,
    },
    {
      "imagePath": ImageConstant.imgImage3,
      "brand": "Dorothy Perkins",
      "title": "Sport Dress",
      "originalPrice": "14\$",
      "salePrice": "12\$",
      "discount": "-20%",
      "rating": 5.0,
      "reviewCount": 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray_50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBanner(),
            SizedBox(height: 26.h),
            _buildSaleSection(context),
            SizedBox(height: 26.h),
            _buildNewSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      margin: EdgeInsets.only(right: 16.h),
      width: double.infinity,
      height: 134.h,
      child: Stack(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgPexelsPhoto911677,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h, left: 14.h),
                  child: Text(
                    'Street clothes',
                    style: TextStyleHelper.instance.headline34BlackMetropolis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaleSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Sale', 'Super summer sale', 'View all'),
          SizedBox(height: 16.h),
          Container(
            height: 280.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              itemCount: saleProducts.length,
              separatorBuilder: (context, index) => SizedBox(width: 14.h),
              itemBuilder: (context, index) {
                return SaleProductItemWidget(
                  productData: saleProducts[index],
                  onTap: () => _onProductTap(context),
                  onFavoriteTap: () => _onFavoriteTap(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              'New', 'You\'ve never seen it before!', 'View all'),
          SizedBox(height: 16.h),
          Container(
            height: 282.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              itemCount: newProducts.length,
              separatorBuilder: (context, index) => SizedBox(width: 16.h),
              itemBuilder: (context, index) {
                return ProductItemWidget(
                  productData: newProducts[index],
                  onTap: () => _onProductTap(context),
                  onFavoriteTap: () => _onFavoriteTap(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, String actionText) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyleHelper.instance.headline34BoldMetropolis,
              ),
              Text(
                subtitle,
                style: TextStyleHelper.instance.label11RegularMetropolis,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 28.h),
          child: Text(
            actionText,
            style: TextStyleHelper.instance.label11RegularMetropolis
                .copyWith(color: appTheme.gray_900),
          ),
        ),
      ],
    );
  }

  void _onProductTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.productDetailScreen);
  }

  void _onFavoriteTap() {
    // Handle favorite tap
  }
}
