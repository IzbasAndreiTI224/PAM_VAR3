class EcommerceData {
  final Header header;
  final List<Section> sections;

  EcommerceData({required this.header, required this.sections});

  factory EcommerceData.fromJson(Map<String, dynamic> json) {
    return EcommerceData(
      header: Header.fromJson(json['header']),
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Header {
  final String title;
  final String bannerImage;

  Header({required this.title, required this.bannerImage});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      title: json['title'] ?? '',
      bannerImage: json['bannerImage'] ?? '',
    );
  }
}

class Section {
  final String title;
  final String subtitle;
  final List<Product> items;

  Section({required this.title, required this.subtitle, required this.items});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      items: (json['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String brand;
  final String name;
  final String image;
  final double? oldPrice;
  final double? newPrice;
  final double? price;
  final int? discount;
  final bool isNew;
  final double rating;
  final int reviews;
  final bool isFavorite;

  Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.image,
    this.oldPrice,
    this.newPrice,
    this.price,
    this.discount,
    this.isNew = false,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      brand: json['brand'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      oldPrice: json['oldPrice']?.toDouble(),
      newPrice: json['newPrice']?.toDouble(),
      price: json['price']?.toDouble(),
      discount: json['discount'],
      isNew: json['isNew'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviews: json['reviews'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Product copyWith({
    bool? isFavorite,
  }) {
    return Product(
      id: id,
      brand: brand,
      name: name,
      image: image,
      oldPrice: oldPrice,
      newPrice: newPrice,
      price: price,
      discount: discount,
      isNew: isNew,
      rating: rating,
      reviews: reviews,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ProductDetails {
  final ProductDetail product;
  final List<RelatedProduct> relatedProducts;

  ProductDetails({required this.product, required this.relatedProducts});

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      product: ProductDetail.fromJson(json['product']),
      relatedProducts: (json['relatedProducts'] as List)
          .map((product) => RelatedProduct.fromJson(product))
          .toList(),
    );
  }
}

class ProductDetail {
  final String id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final String currency;
  final double rating;
  final int reviewsCount;
  final List<ColorOption> colors;
  final List<String> sizes;
  final ShippingInfo shippingInfo;
  final Support support;
  final Actions actions;

  ProductDetail({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.currency,
    required this.rating,
    required this.reviewsCount,
    required this.colors,
    required this.sizes,
    required this.shippingInfo,
    required this.support,
    required this.actions,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'USD',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      colors: (json['colors'] as List)
          .map((color) => ColorOption.fromJson(color))
          .toList(),
      sizes: (json['sizes'] as List).map((size) => size.toString()).toList(),
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo']),
      support: Support.fromJson(json['support']),
      actions: Actions.fromJson(json['actions']),
    );
  }
}

class ColorOption {
  final String name;
  final String hex;
  final List<String> images;

  ColorOption({required this.name, required this.hex, required this.images});

  factory ColorOption.fromJson(Map<String, dynamic> json) {
    return ColorOption(
      name: json['name'] ?? '',
      hex: json['hex'] ?? '',
      images: (json['images'] as List).map((image) => image.toString()).toList(),
    );
  }
}

class ShippingInfo {
  final String delivery;
  final String returns;

  ShippingInfo({required this.delivery, required this.returns});

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      delivery: json['delivery'] ?? '',
      returns: json['returns'] ?? '',
    );
  }
}

class Support {
  final String contactEmail;
  final String faqUrl;

  Support({required this.contactEmail, required this.faqUrl});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      contactEmail: json['contactEmail'] ?? '',
      faqUrl: json['faqUrl'] ?? '',
    );
  }
}

class Actions {
  final bool addToCart;
  final bool addToWishlist;
  final bool share;

  Actions({
    required this.addToCart,
    required this.addToWishlist,
    required this.share,
  });

  factory Actions.fromJson(Map<String, dynamic> json) {
    return Actions(
      addToCart: json['addToCart'] ?? false,
      addToWishlist: json['addToWishlist'] ?? false,
      share: json['share'] ?? false,
    );
  }
}

class RelatedProduct {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? oldPrice;
  final String currency;
  final String? discount;
  final double rating;
  final int reviewsCount;
  final String image;

  RelatedProduct({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.currency,
    this.discount,
    required this.rating,
    required this.reviewsCount,
    required this.image,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      oldPrice: json['oldPrice']?.toDouble(),
      currency: json['currency'] ?? 'USD',
      discount: json['discount'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}