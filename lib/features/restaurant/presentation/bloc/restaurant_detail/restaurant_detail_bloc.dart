import 'package:dicoding_restaurant/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_detail_event.dart';
import 'restaurant_detail_state.dart';

class RestaurantDetailBloc extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final RestaurantRepository repository;

  RestaurantDetailBloc(this.repository) : super(RestaurantDetailInitial()) {
    on<FetchRestaurantDetail>(_onFetchRestaurantDetail);
  }

  void _onFetchRestaurantDetail(
      FetchRestaurantDetail event, Emitter<RestaurantDetailState> emit) async {
    emit(RestaurantDetailLoading());
    try {
      final restaurant = await repository.detailRestaurant(event.id);
      emit(RestaurantDetailLoaded(restaurant));
    } catch (e) {
      emit(RestaurantDetailError(e.toString()));
    }
  }
}
