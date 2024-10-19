abstract class RestaurantDetailEvent {}

class FetchRestaurantDetail extends RestaurantDetailEvent {
  final String id;
  FetchRestaurantDetail(this.id);
}
