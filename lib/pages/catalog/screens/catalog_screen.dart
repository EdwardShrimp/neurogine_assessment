import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurogine_assessment/app/router/route_names.dart';
import 'package:neurogine_assessment/pages/catalog/controllers/catalog_listing_controller.dart';
import 'package:neurogine_assessment/pages/catalog/controllers/catalog_listing_state.dart';
import 'package:neurogine_assessment/pages/catalog/data/models/catalog_listing_models.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 255, 161),
        title: const Text('Catalog'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: const _CatalogSearchField(),
          ),
        ),
      ),
      body: BlocBuilder<CatalogListingController, CatalogListingState>(
        builder: (context, state) {
          return switch (state) {
            CatalogListingInitial() || CatalogListingLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CatalogListingError(:final message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<CatalogListingController>()
                        .loadInitialCatalog(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            CatalogListingSuccess(:final products, :final isLoadingMore) =>
              _CatalogList(products: products, isLoadingMore: isLoadingMore),
          };
        },
      ),
    );
  }
}

class _CatalogList extends StatelessWidget {
  const _CatalogList({required this.products, required this.isLoadingMore});

  final List<CatalogListingModel> products;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final nearBottom = metrics.pixels >= metrics.maxScrollExtent - 200;
        if (metrics.maxScrollExtent > 0 && nearBottom) {
          context.read<CatalogListingController>().loadMore();
        }
        return false;
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: products.length + (isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index >= products.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final product = products[index];
            return GestureDetector(
              onTap: () => context.pushNamed(
                RouteNames.productDetails,
                pathParameters: {'id': product.id.toString()},
              ),
              child: _CatalogItem(product: product),
            );
          },
        ),
      ),
    );
  }
}

class _CatalogSearchField extends StatefulWidget {
  const _CatalogSearchField();

  @override
  State<_CatalogSearchField> createState() => _CatalogSearchFieldState();
}

class _CatalogSearchFieldState extends State<_CatalogSearchField> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _keywordController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () {
            context.read<CatalogListingController>().searchProduct(
              _keywordController.text,
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
          ),
          child: const Text('Search'),
        ),
      ],
    );
  }
}

class _CatalogItem extends StatelessWidget {
  const _CatalogItem({required this.product});

  final CatalogListingModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      ///
      /// Product Thumbnail
      ///
      leading: Image.network(
        product.thumbnailUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
      ),

      ///
      /// Product Title
      ///
      title: Text(product.title),

      ///
      /// Product Price and Rating
      ///
      subtitle: Text(
        'RM${product.price.toStringAsFixed(2)}  · ★${product.rating.toStringAsFixed(1)}',
      ),
    );
  }
}
