import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/ecommerce_entities.dart';
import '../../../domain/use_cases/ecommerce_use_cases.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  final GetEcommerceDataUseCase getEcommerceData;
  final GetProductDetailsUseCase getProductDetails;
  final ToggleProductFavoriteUseCase toggleProductFavorite;

  EcommerceBloc({
    required this.getEcommerceData,
    required this.getProductDetails,
    required this.toggleProductFavorite,
  }) : super(EcommerceInitial()) {
    on<LoadEcommerceData>(_onLoadEcommerceData);
    on<ToggleProductFavorite>(_onToggleProductFavorite);
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  late EcommerceData _ecommerceData;
  late ProductDetails _productDetails;

  Future<void> _onLoadEcommerceData(
      LoadEcommerceData event,
      Emitter<EcommerceState> emit,
      ) async {
    emit(EcommerceLoading());
    try {
      _ecommerceData = await getEcommerceData();
      emit(EcommerceLoaded(ecommerceData: _ecommerceData));
    } catch (e) {
      emit(EcommerceError(error: 'Failed to load data: $e'));
    }
  }

  void _onToggleProductFavorite(
      ToggleProductFavorite event,
      Emitter<EcommerceState> emit,
      ) async {
    if (state is EcommerceLoaded) {
      try {
        await toggleProductFavorite(event.productId, event.isFavorite);

        final currentState = state as EcommerceLoaded;
        final updatedSections = currentState.ecommerceData.sections.map((section) {
          final updatedItems = section.items.map((product) {
            if (product.id == event.productId) {
              return product.copyWith(isFavorite: event.isFavorite);
            }
            return product;
          }).toList();

          return Section(
            title: section.title,
            subtitle: section.subtitle,
            items: updatedItems,
          );
        }).toList();

        final updatedEcommerceData = EcommerceData(
          header: currentState.ecommerceData.header,
          sections: updatedSections,
        );

        _ecommerceData = updatedEcommerceData;
        emit(EcommerceLoaded(ecommerceData: updatedEcommerceData));
      } catch (e) {
        emit(EcommerceError(error: 'Failed to toggle favorite: $e'));
      }
    }
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event,
      Emitter<EcommerceState> emit,
      ) async {
    if (state is EcommerceLoaded) {
      emit(ProductDetailsLoading());
      try {
        _productDetails = await getProductDetails();
        emit(ProductDetailsLoaded(
          ecommerceData: _ecommerceData,
          productDetails: _productDetails,
        ));
      } catch (e) {
        emit(EcommerceError(error: 'Failed to load product details: $e'));
      }
    }
  }
}