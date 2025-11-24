import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_export.dart';
import 'data/network/api_client.dart';
import 'data/repositories/ecommerce_repository_impl.dart';
import 'domain/repositories/ecommerce_repository.dart';
import 'domain/use_cases/ecommerce_use_cases.dart';
import 'presentation/bloc/ecommerce/ecommerce_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ApiClient>(
              create: (context) => ApiClient(),
            ),
            RepositoryProvider<EcommerceRepository>(
              create: (context) => EcommerceRepositoryImpl(
                apiClient: context.read<ApiClient>(),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<EcommerceBloc>(
                create: (context) => EcommerceBloc(
                  getEcommerceData: GetEcommerceDataUseCase(
                    context.read<EcommerceRepository>(),
                  ),
                  getProductDetails: GetProductDetailsUseCase(
                    context.read<EcommerceRepository>(),
                  ),
                  toggleProductFavorite: ToggleProductFavoriteUseCase(
                    context.read<EcommerceRepository>(),
                  ),
                )..add(LoadEcommerceData()),
              ),
            ],
            child: MaterialApp(
              title: 'Ecommerce App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: AppRoutes.initialRoute,
            ),
          ),
        );
      },
    );
  }
}