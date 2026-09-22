import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:neurogine_assessment/app/router/route_names.dart';
import 'package:neurogine_assessment/app/router/route_paths.dart';
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
        builder: (context, state) => Text('Catalog'), //const CatalogScreen(),
      ),
      GoRoute(
        path: RoutePaths.productDetails,
        name: RouteNames.productDetails,
        builder: (context, state) =>
            Text('Product Details'), //const ProductDetailsScreen(),
      ),
    ],
  );
}
