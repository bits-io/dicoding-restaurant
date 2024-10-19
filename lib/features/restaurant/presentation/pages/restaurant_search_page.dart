import 'package:dicoding_restaurant/core/utils/connection.dart';
import 'package:dicoding_restaurant/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:dicoding_restaurant/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_detail_page.dart';
import 'package:http/http.dart' as http;

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _searchRestaurant(String query) {
    // Dispatch search event to the RestaurantBloc
    context.read<RestaurantBloc>().add(SearchRestaurantsEvent(query));
  }

  @override
  Widget build(BuildContext context) {

    final RestaurantRemoteDataSource restaurantRemoteDataSource =
        RestaurantRemoteDataSourceImpl(http.Client());
    final restaurantRepository =
        RestaurantRepositoryImpl(remoteDataSource: restaurantRemoteDataSource);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search restaurants...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchRestaurant(_searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (query) {
                _searchRestaurant(query);
              },
            ),
          ),
          // BlocBuilder to display search results
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => ConnectivityCubit(), // Provide the connectivity cubit
                ),
                BlocProvider(
                  create: (context) => RestaurantBloc(repository: restaurantRepository,
                  )..add(FetchRestaurantsEvent()),
                ),
              ],
              child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
                builder: (context, connectivityState) {
                  if (connectivityState == ConnectivityStatus.disconnected) {
                    return Center(
                      child: Text(
                        "No Internet Connection. Please check your connection and try again.",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return BlocBuilder<RestaurantBloc, RestaurantState>(
                      builder: (context, state) {
                        if (state is RestaurantLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is RestaurantLoaded) {
                          if (state.restaurants.isEmpty) {
                            return const Center(child: Text('No restaurants found'));
                          }
                          return ListView.builder(
                            itemCount: state.restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = state.restaurants[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantDetailPage(id: restaurant.id),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 120.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              restaurant.name,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              restaurant.city,
                                              style: TextStyle(
                                                  fontSize: 14.0, color: Colors.grey),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star, color: Colors.orange),
                                                SizedBox(width: 4),
                                                Text(restaurant.rating.toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 4.0),
                                ),
                              );
                            },
                          );
                        } else if (state is RestaurantError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(child: Text('No Data'));
                        }
                      },
                    );
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
