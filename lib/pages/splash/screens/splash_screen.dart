import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurogine_assessment/app/router/route_paths.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Neurogine - Catalog App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 5),
              onPressed: () {
                context.go(RoutePaths.catalog);
              },
              child: Text('Go to Catalog'),
            ),
          ],
        ),
      ),
    );
  }
}
