import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  final List<String> foods;
  final List<String> drinks;

  RestaurantModel({
    required String id,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    required double rating,
    required this.foods,
    required this.drinks,
  }) : super(
          id: id,
          name: name,
          description: description,
          pictureId: pictureId,
          city: city,
          rating: rating,
          foods: foods,
          drinks: drinks,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: (json['rating'] as num).toDouble(),
      foods: (json['menus']['foods'] as List)
          .map((food) => food['name'].toString())
          .toList(),
      drinks: (json['menus']['drinks'] as List)
          .map((drink) => drink['name'].toString())
          .toList(),
    );
  }
}
