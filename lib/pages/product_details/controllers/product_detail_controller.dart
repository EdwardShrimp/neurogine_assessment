import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_state.dart';
import 'package:neurogine_assessment/pages/product_details/data/models/product_detail_models.dart';
import 'package:neurogine_assessment/pages/product_details/data/repositories/product_detail_repositories.dart';

class ProductDetailController extends Cubit<ProductDetailsState> {
  ProductDetailController({
    required this.productDetailRepositories,
    required this.id,
  }) : super(const ProductDetailsInitial());

  final ProductDetailRepositories productDetailRepositories;
  final int id;

  Future<void> loadProductDetails() async {
    emit(const ProductDetailsLoading());
    try {
      final data = await productDetailRepositories.getProductDetail(id: id);
      emit(ProductDetailsSuccess(details: ProductDetailModel.fromJson(data)));
    } catch (error) {
      emit(ProductDetailsError(error.toString()));
    }
  }
}
