/// Export pentru domain
export '../domain/entities/ecommerce_entities.dart';
export '../domain/repositories/ecommerce_repository.dart';
export '../domain/use_cases/ecommerce_use_cases.dart';

// Export pentru data
export '../data/network/api_client.dart';
export '../data/repositories/ecommerce_repository_impl.dart';

// Export pentru presentation bloc
export '../presentation/bloc/ecommerce/ecommerce_bloc.dart';
// Elimină exporturile pentru event și state deoarece sunt part files

// Export pentru presentation pages
export '../presentation/pages/fashion_home_screen/fashion_home_screen.dart';
export '../presentation/pages/product_detail_screen/product_detail_screen.dart';
export '../presentation/pages/app_navigation_screen/app_navigation_screen.dart';

// Export pentru presentation widgets
export '../presentation/widgets/custom_app_bar.dart';
export '../presentation/widgets/custom_button.dart';
export '../presentation/widgets/custom_dropdown.dart';
export '../presentation/widgets/custom_icon_button.dart';
export '../presentation/widgets/custom_image_view.dart';
export '../presentation/widgets/custom_rating_bar.dart';
export '../presentation/widgets/custom_rating_display.dart';

// Exporturi core (actualizate)
export 'routes/app_routes.dart';
export 'theme/theme_helper.dart';
export 'theme/text_style_helper.dart';
export 'utils/image_constant.dart';
export 'utils/size_utils.dart';