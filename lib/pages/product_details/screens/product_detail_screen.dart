import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_controller.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_state.dart';
import 'package:neurogine_assessment/pages/product_details/data/models/product_detail_models.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailController, ProductDetailsState>(
        builder: (context, state) {
          return switch (state) {
            ProductDetailsInitial() || ProductDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductDetailsError(:final message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<ProductDetailController>()
                        .loadProductDetails(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            ProductDetailsSuccess(:final details) => _ProductDetail(
              details: details,
            ),
          };
        },
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({required this.details});

  final ProductDetailModel details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(details.title),
        Text(details.description),
        Text(details.price.toString()),
      ],
    );
  }
}
