import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_export.dart';
import '../../core/bloc/ecommerce/ecommerce_bloc.dart';
import '../../core/models/ecommerce_models.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/product_item_widget.dart';
import './widgets/sale_product_item_widget.dart';

class FashionHomeScreen extends StatelessWidget {
  const FashionHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray_50,
      body: BlocBuilder<EcommerceBloc, EcommerceState>(
        builder: (context, state) {
          if (state is EcommerceLoading) {
            return _buildLoadingState();
          } else if (state is EcommerceError) {
            return _buildErrorState(context, state.error);
          } else if (state is EcommerceLoaded) {
            return _buildLoadedState(context, state.ecommerceData);
          }
          return _buildLoadingState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: appTheme.gray_500),
          SizedBox(height: 16.h),
          Text(
            'Error loading data',
            style: TextStyleHelper.instance.title18SemiBoldMetropolis,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.h),
            child: Text(
              error,
              style: TextStyleHelper.instance.body14RegularMetropolis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              context.read<EcommerceBloc>().add(LoadEcommerceData());
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, EcommerceData ecommerceData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderBanner(ecommerceData.header),
          SizedBox(height: 26.h),
          ...ecommerceData.sections.map((section) {
            return Column(
              children: [
                _buildSection(context, section),
                SizedBox(height: 26.h),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner(Header header) {
    return Container(
      margin: EdgeInsets.only(right: 16.h),
      width: double.infinity,
      height: 134.h,
      child: Stack(
        children: [
          CustomImageView(
            imagePath: header.bannerImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h, left: 14.h),
              child: Text(
                header.title,
                style: TextStyleHelper.instance.headline34BlackMetropolis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, Section section) {
    final isSaleSection = section.title == 'Sale';

    return Container(
      margin: EdgeInsets.only(left: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            section.title,
            section.subtitle,
            'View all',
          ),
          SizedBox(height: 16.h),
          Container(
            height: 280.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              itemCount: section.items.length,
              separatorBuilder: (context, index) => SizedBox(width: 14.h),
              itemBuilder: (context, index) {
                final product = section.items[index];

                if (isSaleSection) {
                  return SaleProductItemWidget(
                    product: product,
                    onTap: () => _onProductTap(context),
                    onFavoriteTap: () => _onFavoriteTap(context, product),
                  );
                } else {
                  return ProductItemWidget(
                    product: product,
                    onTap: () => _onProductTap(context),
                    onFavoriteTap: () => _onFavoriteTap(context, product),
                  );
                }
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
              SizedBox(height: 4.h),
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
    context.read<EcommerceBloc>().add(LoadProductDetails());
    Navigator.of(context).pushNamed(AppRoutes.productDetailScreen);
  }

  void _onFavoriteTap(BuildContext context, Product product) {
    context.read<EcommerceBloc>().add(
      ToggleProductFavorite(
        productId: product.id,
        isFavorite: !product.isFavorite,
      ),
    );
  }
}