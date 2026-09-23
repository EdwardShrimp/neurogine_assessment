class CatalogListingModel {
  final int id;
  final String title;
  final String thumbnailUrl;
  final double price;
  final double discountPercentage;
  final double rating;

  CatalogListingModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.price,
    required this.discountPercentage,
    required this.rating,
  });

  factory CatalogListingModel.fromJson(Map<String, dynamic> json) {
    return CatalogListingModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      thumbnailUrl: json['thumbnail'] ?? "",
      price: (json['price']).toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage']).toDouble() ?? 0.0,
      rating: (json['rating']).toDouble() ?? 0.0,
    );
  }
}
