import 'package:dicoding_restaurant/core/utils/connection.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_state.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/pages/restaurant_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocListener<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, state) {
          if (state == ConnectivityStatus.disconnected) {            
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('No Internet Connection'),
                content: const Text('Please check your network settings.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RestaurantSearchPage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Search restaurant'),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Restaurants',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Find the best restaurants in town',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.restaurants[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantDetailPage(restaurant: restaurant),
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
                                          "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"),
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
                    ),
                  ),
                ],
              );
            } else if (state is RestaurantError) {
              return Center(child: Text(state.message));
            } else {
              return Center(
                child: Text('No Data'),
              );
            }
          },
        ),
      ),
    );
  }
}
