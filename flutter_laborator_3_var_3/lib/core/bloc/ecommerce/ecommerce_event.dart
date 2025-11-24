part of 'ecommerce_bloc.dart';

abstract class EcommerceEvent extends Equatable {
  const EcommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadEcommerceData extends EcommerceEvent {}

class ToggleProductFavorite extends EcommerceEvent {
  final int productId;
  final bool isFavorite;

  const ToggleProductFavorite({
    required this.productId,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [productId, isFavorite];
}

class LoadProductDetails extends EcommerceEvent {
  const LoadProductDetails();

  @override
  List<Object> get props => [];
}