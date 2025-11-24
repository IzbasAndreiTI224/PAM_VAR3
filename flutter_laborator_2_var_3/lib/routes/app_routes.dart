import 'package:flutter/material.dart';
import '../presentation/fashion_home_screen/fashion_home_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String fashionHomeScreen = '/fashion_home_screen';
  static const String productDetailScreen = '/product_detail_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
    fashionHomeScreen: (context) => FashionHomeScreen(),
    productDetailScreen: (context) => ProductDetailScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => AppNavigationScreen()
  };
}
