import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.address,
    required super.pictureId,
    required super.categories,
    required super.menus,
    required super.rating,
    required super.customerReviews,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      city: json['city'] as String? ?? '',
      address: json['address'] as String? ?? '',
      pictureId: json['pictureId'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((category) => Category(name: category?['name'] as String? ?? ''))
          .toList(),
      menus: Menus(
        foods: (json['menus']?['foods'] as List<dynamic>? ?? [])
            .map((food) => Category(name: food?['name'] as String? ?? ''))
            .toList(),
        drinks: (json['menus']?['drinks'] as List<dynamic>? ?? [])
            .map((drink) => Category(name: drink?['name'] as String? ?? ''))
            .toList(),
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      customerReviews: (json['customerReviews'] as List<dynamic>? ?? [])
          .map((review) => CustomerReview(
                name: review?['name'] as String? ?? '',
                review: review?['review'] as String? ?? '',
                date: review?['date'] as String? ?? '',
              ))
          .toList(),
    );
  }
}
