import 'package:flutter/material.dart';
import '../../presentation/pages/fashion_home_screen/fashion_home_screen.dart';
import '../../presentation/pages/product_detail_screen/product_detail_screen.dart';
import '../../presentation/pages/app_navigation_screen/app_navigation_screen.dart';

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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case fashionHomeScreen:
        return MaterialPageRoute(builder: (_) => FashionHomeScreen());
      case productDetailScreen:
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      case appNavigationScreen:
        return MaterialPageRoute(builder: (_) => AppNavigationScreen());
      case initialRoute:
        return MaterialPageRoute(builder: (_) => AppNavigationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}