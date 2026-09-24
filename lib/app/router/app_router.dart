import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurogine_assessment/app/router/route_names.dart';
import 'package:neurogine_assessment/app/router/route_paths.dart';
import 'package:neurogine_assessment/pages/catalog/controllers/catalog_listing_controller.dart';
import 'package:neurogine_assessment/pages/catalog/data/repositories/catalog_listing_repositories.dart';
import 'package:neurogine_assessment/pages/catalog/screens/catalog_screen.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_controller.dart';
import 'package:neurogine_assessment/pages/product_details/data/repositories/product_detail_repositories.dart';
import 'package:neurogine_assessment/pages/product_details/screens/product_detail_screen.dart';
import 'package:neurogine_assessment/pages/splash/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.catalog,
        name: RouteNames.catalog,
        builder: (context, state) => BlocProvider(
          create: (_) => CatalogListingController(
            catalogListingRepositories: CatalogListingRepositories(),
          )..loadInitialCatalog(),
          child: const CatalogScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.productDetails,
        name: RouteNames.productDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BlocProvider(
            create: (_) => ProductDetailController(
              productDetailRepositories: ProductDetailRepositories(),
              id: id,
            )..loadProductDetails(),
            child: const ProductDetailScreen(),
          );
        },
      ),
    ],
  );
}
