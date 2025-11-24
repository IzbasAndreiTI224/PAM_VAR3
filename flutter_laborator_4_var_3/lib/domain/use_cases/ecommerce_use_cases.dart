import '../entities/ecommerce_entities.dart';
import '../repositories/ecommerce_repository.dart';

class GetEcommerceDataUseCase {
  final EcommerceRepository repository;

  GetEcommerceDataUseCase(this.repository);

  Future<EcommerceData> call() {
    return repository.getEcommerceData();
  }
}

class GetProductDetailsUseCase {
  final EcommerceRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<ProductDetails> call() {
    return repository.getProductDetails();
  }
}

class ToggleProductFavoriteUseCase {
  final EcommerceRepository repository;

  ToggleProductFavoriteUseCase(this.repository);

  Future<void> call(int productId, bool isFavorite) {
    return repository.toggleProductFavorite(productId, isFavorite);
  }
}