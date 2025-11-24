import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/ecommerce_models.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  EcommerceBloc() : super(EcommerceInitial()) {
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
      await Future.delayed(Duration(milliseconds: 500));

      final String ecommerceJsonString = await rootBundle.loadString('assets/data/ecommerce_data.json');
      final Map<String, dynamic> ecommerceJson = json.decode(ecommerceJsonString);

      _ecommerceData = EcommerceData.fromJson(ecommerceJson);

      emit(EcommerceLoaded(ecommerceData: _ecommerceData));
    } catch (e) {
      emit(EcommerceError(error: 'Failed to load data: $e'));
    }
  }

  void _onToggleProductFavorite(
      ToggleProductFavorite event,
      Emitter<EcommerceState> emit,
      ) {
    if (state is EcommerceLoaded) {
      final currentState = state as EcommerceLoaded;

      // Update favorite status in all sections
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
    }
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event,
      Emitter<EcommerceState> emit,
      ) async {
    if (state is EcommerceLoaded) {
      emit(ProductDetailsLoading());
      try {
        await Future.delayed(Duration(milliseconds: 300));

        final String detailsJsonString = await rootBundle.loadString('assets/data/product_details.json');
        final Map<String, dynamic> detailsJson = json.decode(detailsJsonString);

        _productDetails = ProductDetails.fromJson(detailsJson);

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