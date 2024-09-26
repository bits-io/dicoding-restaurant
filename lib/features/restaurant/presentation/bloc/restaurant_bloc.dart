import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantBloc extends Cubit<List<Restaurant>> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository}) : super([]);

  void fetchRestaurants() async {
    final restaurants = await repository.getRestaurants();
    emit(restaurants);
  }
}