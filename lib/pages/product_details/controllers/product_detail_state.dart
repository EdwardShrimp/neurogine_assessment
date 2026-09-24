import 'package:neurogine_assessment/pages/product_details/data/models/product_detail_models.dart';

sealed class ProductDetailsState {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

class ProductDetailsSuccess extends ProductDetailsState {
  const ProductDetailsSuccess({required this.details});

  final ProductDetailModel details;
}

class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError(this.message);

  final String message;
}
