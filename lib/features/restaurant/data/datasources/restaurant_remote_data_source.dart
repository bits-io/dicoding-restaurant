import 'dart:convert';
import 'package:dicoding_restaurant/core/api/api.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getAllRestaurant();
  Future<List<RestaurantModel>> searchRestaurants(String query);
  Future<RestaurantModel> detailRestaurant(String id);
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

  @override
  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response =
        await http.get(Uri.parse(Api.dicoding.baseUrl + Api.dicoding.search + query));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final List restaurants = jsonMap['restaurants'];
      return restaurants.map((json) => RestaurantModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Future<RestaurantModel> detailRestaurant(String id) async {
    final response = await http
        .get(Uri.parse(Api.dicoding.baseUrl + Api.dicoding.detail + id));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);      
      return RestaurantModel.fromJson(jsonMap['restaurant']);      
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
