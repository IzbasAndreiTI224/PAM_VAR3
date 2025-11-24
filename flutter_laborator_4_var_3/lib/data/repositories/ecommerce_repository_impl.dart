import '../../../domain/entities/ecommerce_entities.dart';
import '../../../domain/repositories/ecommerce_repository.dart';
import '../network/api_client.dart';
import '../models/ecommerce_models.dart';

class EcommerceRepositoryImpl implements EcommerceRepository {
  final ApiClient apiClient;

  EcommerceRepositoryImpl({required this.apiClient});

  @override
  Future<EcommerceData> getEcommerceData() async {
    try {
      final jsonData = await apiClient.getFeed();
      final cleanedJsonData = _cleanProductNames(jsonData);
      return EcommerceDataModel.fromJson(cleanedJsonData);
    } catch (e) {
      throw Exception('Failed to load ecommerce data: $e');
    }
  }

  @override
  Future<ProductDetails> getProductDetails() async {
    try {
      final jsonData = await apiClient.getFeedDetails();
      final cleanedJsonData = _cleanProductNames(jsonData);
      return ProductDetailsModel.fromJson(cleanedJsonData);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }

  @override
  Future<void> toggleProductFavorite(int productId, bool isFavorite) async {
    await Future.delayed(Duration(milliseconds: 300));
    return;
  }

  Map<String, dynamic> _cleanProductNames(Map<String, dynamic> jsonData) {
    final cleanedData = Map<String, dynamic>.from(jsonData);

    if (cleanedData.containsKey('sections')) {
      final sections = List<dynamic>.from(cleanedData['sections'] ?? []);
      for (int i = 0; i < sections.length; i++) {
        final section = Map<String, dynamic>.from(sections[i]);
        if (section.containsKey('items')) {
          final items = List<dynamic>.from(section['items'] ?? []);
          for (int j = 0; j < items.length; j++) {
            final item = Map<String, dynamic>.from(items[j]);
            if (item.containsKey('name')) {
              item['name'] = _cleanName(item['name']);
            }
            items[j] = item;
          }
          section['items'] = items;
        }
        sections[i] = section;
      }
      cleanedData['sections'] = sections;
    }

    if (cleanedData.containsKey('product')) {
      final product = Map<String, dynamic>.from(cleanedData['product']);
      if (product.containsKey('title')) {
        product['title'] = _cleanName(product['title']);
      }
      if (product.containsKey('description')) {
        product['description'] = _cleanName(product['description']);
      }
      cleanedData['product'] = product;
    }

    if (cleanedData.containsKey('relatedProducts')) {
      final relatedProducts = List<dynamic>.from(cleanedData['relatedProducts'] ?? []);
      for (int i = 0; i < relatedProducts.length; i++) {
        final relatedProduct = Map<String, dynamic>.from(relatedProducts[i]);
        if (relatedProduct.containsKey('title')) {
          relatedProduct['title'] = _cleanName(relatedProduct['title']);
        }
        relatedProducts[i] = relatedProduct;
      }
      cleanedData['relatedProducts'] = relatedProducts;
    }

    return cleanedData;
  }

  String _cleanName(String name) {
    if (name is String) {
      return name
          .replaceAll('(Grey)', '')
          .replaceAll('(grey)', '')
          .replaceAll('(Gray)', '')
          .replaceAll('(gray)', '')
          .replaceAll('(Gri)', '')
          .replaceAll('(gri)', '')
          .trim();
    }
    return name;
  }
}