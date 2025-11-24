import '../../../domain/entities/ecommerce_entities.dart';

class EcommerceDataModel extends EcommerceData {
  EcommerceDataModel({required super.header, required super.sections});

  factory EcommerceDataModel.fromJson(Map<String, dynamic> json) {
    return EcommerceDataModel(
      header: Header.fromJson(json['header']),
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class ProductDetailsModel extends ProductDetails {
  ProductDetailsModel({required super.product, required super.relatedProducts});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: ProductDetail.fromJson(json['product']),
      relatedProducts: (json['relatedProducts'] as List)
          .map((product) => RelatedProduct.fromJson(product))
          .toList(),
    );
  }
}