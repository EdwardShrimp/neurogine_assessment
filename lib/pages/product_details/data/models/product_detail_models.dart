class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<ReviewModel> reviews;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.reviews,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      images: (json['images'] as List<dynamic>? ?? [])
          .map((image) => image as String)
          .toList(),
      price: (json['price']).toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage']).toDouble() ?? 0.0,
      rating: (json['rating']).toDouble() ?? 0.0,
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((review) => ReviewModel.fromJson(review as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReviewModel {
  final int rating;
  final String comment;
  final DateTime date;
  final String name;
  final String email;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.name,
    required this.email,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? "",
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      name: json['reviewerName'] ?? "",
      email: json['reviewerEmail'] ?? "",
    );
  }
}
