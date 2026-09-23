import 'package:neurogine_assessment/pages/catalog/data/models/catalog_listing_models.dart';

sealed class CatalogListingState {
  const CatalogListingState();
}

class CatalogListingInitial extends CatalogListingState {
  const CatalogListingInitial();
}

class CatalogListingLoading extends CatalogListingState {
  const CatalogListingLoading();
}

class CatalogListingSuccess extends CatalogListingState {
  const CatalogListingSuccess({
    required this.products,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<CatalogListingModel> products;
  final bool hasMore;
  final bool isLoadingMore;
}

class CatalogListingError extends CatalogListingState {
  const CatalogListingError(this.message);

  final String message;
}
