import 'package:flutter/material.dart';
import 'package:neurogine_assessment/app/router/app_router.dart';

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 246, 247, 232),
      ),
      title: 'Neurogine - Catalog App',
      routerConfig: AppRouter.router,
    );
  }
}
