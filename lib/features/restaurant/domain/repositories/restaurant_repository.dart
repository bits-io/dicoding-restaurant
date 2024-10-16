import '../../domain/entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants();
  Future<List<Restaurant>> searchRestaurants(String query);
}
