import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/restaurant_model.dart';

class RestaurantLocalDataSource {
  Future<List<RestaurantModel>> getRestaurantsFromJson() async {
    final jsonString =
        await rootBundle.loadString('json/local_restaurant.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List restaurants = jsonMap['restaurants'];
    return restaurants.map((json) => RestaurantModel.fromJson(json)).toList();
  }
}
