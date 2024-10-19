import 'package:dicoding_restaurant/core/utils/connection.dart';
import 'package:dicoding_restaurant/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant_detail/restaurant_detail_event.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant_detail/restaurant_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;

  const RestaurantDetailPage({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConnectivityCubit(), // Provide the connectivity cubit
        ),
        BlocProvider(
          create: (context) => RestaurantDetailBloc(
            context.read<RestaurantRepository>(),
          )..add(FetchRestaurantDetail(id)),
        ),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
        builder: (context, connectivityState) {
          if (connectivityState == ConnectivityStatus.disconnected) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Connection Error"),
              ),
              body: Center(
                child: Text(
                  "No Internet Connection. Please check your connection and try again.",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
              builder: (context, state) {
                if (state is RestaurantDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RestaurantDetailLoaded) {
                  final Restaurant restaurant = state.restaurant;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(restaurant.name),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                                "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      restaurant.city,
                                      style:
                                          TextStyle(fontSize: 18, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange),
                                    SizedBox(width: 4),
                                    Text(
                                      '${restaurant.rating}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.orange),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(restaurant.description),
                                SizedBox(height: 16),
                                Text(
                                  'Foods',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: restaurant.menus.foods.length,
                                    itemBuilder: (context, index) {
                                      final food = restaurant.menus.foods[index];
                                      return Container(
                                        width: 150,
                                        height: 120,
                                        margin: EdgeInsets.only(right: 8),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                                                fit: BoxFit.cover,
                                                width: 150.0,
                                                height: 120.0,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              left: 8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.black.withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      food.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rp10.000',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Drinks',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: restaurant.menus.drinks.length,
                                    itemBuilder: (context, index) {
                                      final drink = restaurant.menus.drinks[index];
                                      return Container(
                                        width: 150,
                                        height: 120,
                                        margin: EdgeInsets.only(right: 8),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                                                fit: BoxFit.cover,
                                                width: 150.0,
                                                height: 120.0,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              left: 8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.black.withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      drink.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rp8.000',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Customer Review',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  height: 200,  // Tentukan tinggi widget untuk tampilan horizontal
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,  // Scroll horizontal
                                    itemCount: restaurant.customerReviews.length,
                                    itemBuilder: (context, index) {
                                      final review = restaurant.customerReviews[index];
                                      return Card(
                                        elevation: 3,
                                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),  // Margin antar card
                                        child: Container(
                                          width: 250,  // Tentukan lebar tiap card untuk tampilan horizontal
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,  // Sejajarkan konten di kiri
                                            children: [
                                              Text(
                                                review.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                review.date,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                review.review,
                                                style: TextStyle(fontSize: 14),
                                                maxLines: 3,  // Batas maksimal 3 baris teks review
                                                overflow: TextOverflow.ellipsis,  // Teks panjang dipotong
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is RestaurantDetailError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
