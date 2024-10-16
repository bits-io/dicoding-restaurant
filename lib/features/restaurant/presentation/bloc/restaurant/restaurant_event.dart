import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurantsEvent extends RestaurantEvent {}

class SearchRestaurantsEvent extends RestaurantEvent {
  final String query;

  const SearchRestaurantsEvent(this.query);

  @override
  List<Object> get props => [query];
}
