import 'dart:convert';
import 'package:dicoding_restaurant/core/api/api.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getAllRestaurant();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final http.Client client;

  RestaurantRemoteDataSourceImpl(this.client);

  @override
  Future<List<RestaurantModel>> getAllRestaurant() async {
    final response =
        await http.get(Uri.parse(Api.dicoding.baseUrl + Api.dicoding.list));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final List restaurants = jsonMap['restaurants'];
      return restaurants.map((json) => RestaurantModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
