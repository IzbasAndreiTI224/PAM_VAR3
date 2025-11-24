import '../entities/ecommerce_entities.dart';

abstract class EcommerceRepository {
  Future<EcommerceData> getEcommerceData();
  Future<ProductDetails> getProductDetails();
  Future<void> toggleProductFavorite(int productId, bool isFavorite);
}