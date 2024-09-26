import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant_model.dart';

class RestaurantLocalDataSource {
  Future<List<RestaurantModel>> getRestaurantsFromJson() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/bits-io/dicoding-restaurant/main/assets/json/local_restaurant.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List restaurants = jsonMap['restaurants'];
      return restaurants.map((json) => RestaurantModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
