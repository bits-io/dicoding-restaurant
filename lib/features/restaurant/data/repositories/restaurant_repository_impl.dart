import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_data_source.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Restaurant>> getRestaurants() async {
    return await remoteDataSource.getAllRestaurant();
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    return await remoteDataSource.searchRestaurants(query);
  }

  @override
  Future<Restaurant> detailRestaurant(String id) async {
    return await remoteDataSource.detailRestaurant(id);
  }
}
