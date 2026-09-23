import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurogine_assessment/pages/catalog/controllers/catalog_listing_state.dart';
import 'package:neurogine_assessment/pages/catalog/data/models/catalog_listing_models.dart';
import 'package:neurogine_assessment/pages/catalog/data/repositories/catalog_listing_repositories.dart';

class CatalogListingController extends Cubit<CatalogListingState> {
  CatalogListingController({required this.catalogListingRepositories})
    : super(const CatalogListingInitial());

  final CatalogListingRepositories catalogListingRepositories;

  int _skip = 0;

  Future<void> loadCatalog() async {
    emit(const CatalogListingLoading());
    _skip = 0;
    try {
      final data = await catalogListingRepositories.getCatalogListing(
        pagination: _skip,
      );
      final products = _productsFrom(data);
      _skip = products.length;
      emit(
        CatalogListingSuccess(
          products: products,
          hasMore: _hasMore(data, products.length),
        ),
      );
    } catch (error) {
      emit(CatalogListingError(error.toString()));
    }
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! CatalogListingSuccess) return;
    if (!current.hasMore || current.isLoadingMore) return;

    emit(
      CatalogListingSuccess(
        products: current.products,
        hasMore: current.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final data = await catalogListingRepositories.getCatalogListing(
        pagination: _skip,
      );
      final nextProducts = _productsFrom(data);
      final products = [...current.products, ...nextProducts];
      _skip = products.length;
      emit(
        CatalogListingSuccess(
          products: products,
          hasMore: nextProducts.isNotEmpty && _hasMore(data, products.length),
        ),
      );
    } catch (error) {
      emit(CatalogListingSuccess(products: current.products, hasMore: true));
    }
  }

  List<CatalogListingModel> _productsFrom(dynamic data) {
    final productsJson = data['products'] as List<dynamic>;
    return productsJson
        .map(
          (item) => CatalogListingModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  bool _hasMore(dynamic data, int loadedCount) {
    final total = (data['total'] as num?)?.toInt();
    if (total == null) return false;
    return loadedCount < total;
  }
}
