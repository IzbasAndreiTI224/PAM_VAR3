part of 'ecommerce_bloc.dart';

abstract class EcommerceState extends Equatable {
  const EcommerceState();

  @override
  List<Object> get props => [];
}

class EcommerceInitial extends EcommerceState {}

class EcommerceLoading extends EcommerceState {}

class EcommerceLoaded extends EcommerceState {
  final EcommerceData ecommerceData;

  const EcommerceLoaded({required this.ecommerceData});

  @override
  List<Object> get props => [ecommerceData];
}

class ProductDetailsLoading extends EcommerceState {}

class ProductDetailsLoaded extends EcommerceState {
  final EcommerceData ecommerceData;
  final ProductDetails productDetails;

  const ProductDetailsLoaded({
    required this.ecommerceData,
    required this.productDetails,
  });

  @override
  List<Object> get props => [ecommerceData, productDetails];
}

class EcommerceError extends EcommerceState {
  final String error;

  const EcommerceError({required this.error});

  @override
  List<Object> get props => [error];
}