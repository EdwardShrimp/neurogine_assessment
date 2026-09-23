import 'package:neurogine_assessment/app/network/apicall.dart';

class CatalogListingRepositories {
  final ApiCall apiCall = ApiCall.instance;

  Future<dynamic> getCatalogListing({int pagination = 0}) async {
    final response = await apiCall.get('/products?limit=20&skip=$pagination');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load catalog listing');
    }
  }

  Future<dynamic> getCatalogSearchListing({String keyword = ""}) async {
    final response = await apiCall.get('/products/search?q=${keyword.trim()}');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to search catalog listing');
    }
  }
}
