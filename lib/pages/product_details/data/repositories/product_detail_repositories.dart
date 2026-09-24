import 'package:neurogine_assessment/app/network/apicall.dart';

class ProductDetailRepositories {
  final ApiCall apiCall = ApiCall.instance;

  Future<dynamic> getProductDetail({int id = 0}) async {
    final response = await apiCall.get('/products/$id');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load catalog listing');
    }
  }
}
