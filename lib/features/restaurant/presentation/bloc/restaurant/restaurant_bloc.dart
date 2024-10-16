import 'package:dicoding_restaurant/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository}) : super(RestaurantInitial()) {
    on<FetchRestaurantsEvent>(_onFetchRestaurants);
    on<SearchRestaurantsEvent>(_onSearchRestaurants);
  }

  void _onFetchRestaurants(
      FetchRestaurantsEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await repository.getRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  void _onSearchRestaurants(
      SearchRestaurantsEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await repository.searchRestaurants(event.query);
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }
}
