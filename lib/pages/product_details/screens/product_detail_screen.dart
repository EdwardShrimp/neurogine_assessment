import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_controller.dart';
import 'package:neurogine_assessment/pages/product_details/controllers/product_detail_state.dart';
import 'package:neurogine_assessment/pages/product_details/data/models/product_detail_models.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

class _ProductDetail extends StatefulWidget {
  const _ProductDetail({required this.details});

  final ProductDetailModel details;

  @override
  State<_ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<_ProductDetail> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final details = widget.details;

    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ///
                  /// Product Image Carousel
                  ///
                  CarouselSlider(
                    items: details.images
                        .map((image) => Image.network(image))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),

                  ///
                  /// Discount Percentage
                  ///
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 60,
                      height: 30,
                      child: Center(
                        child: Text(
                          "-${details.discountPercentage.toString()}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///
              /// Product Image Carousel Indicators
              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: details.images.asMap().entries.map((entry) {
                  return Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withValues(
                                alpha: _current == entry.key ? 0.9 : 0.4,
                              ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///
                  /// Product Title
                  ///
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      details.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ///
                  /// Product Total Ratings
                  ///
                  Text(
                    "★${details.rating.toString()}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              ///
              /// Product Description
              ///
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  details.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),

              ///
              /// Product Price
              ///
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "RM ${details.price.toString()}",
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(padding: EdgeInsets.all(8.0), child: Divider()),

              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (details.reviews.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No reviews'),
                )
              else
                ...details.reviews
                    .take(5)
                    .map((review) => _ReviewTile(review: review)),

              FilledButton(
                onPressed: () {
                  ///
                  /// TODO: Go to review page, where all reviews can be seen
                  ///
                },
                child: const Text("See more"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${review.date.year}-${review.date.month.toString()}-${review.date.day.toString()} ${review.date.hour.toString().padLeft(2, '0')}:${review.date.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child:
                        ///
                        /// Product Reviewer Name
                        ///
                        Text(
                          review.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),

                  ///
                  /// Product Rating from Reviewer
                  ///
                  Text(
                    '★${review.rating}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              ///
              /// Product Reviewer Email
              ///
              Text(review.email, style: const TextStyle(fontSize: 10)),

              ///
              /// Product Review Date
              ///
              Text(formattedDate, style: const TextStyle(fontSize: 10)),

              Divider(),

              ///
              /// Product Review Comment
              ///
              Text(review.comment, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
