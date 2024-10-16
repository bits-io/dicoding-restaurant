import 'package:dicoding_restaurant/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:dicoding_restaurant/features/restaurant/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'features/restaurant/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'features/restaurant/presentation/pages/restaurant_list_page.dart';
import 'package:http/http.dart' as http;

void main() {
  final RestaurantRemoteDataSource restaurantRemoteDataSource =
      RestaurantRemoteDataSourceImpl(http.Client());
  final restaurantRepository =
      RestaurantRepositoryImpl(remoteDataSource: restaurantRemoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestaurantRepository>(
            create: (context) => restaurantRepository),
        // Add other RepositoryProviders here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RestaurantBloc(repository: context.read<RestaurantRepository>())
                ..add(FetchRestaurantsEvent()),
        ),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RestaurantListPage(),
      ),
    );
  }
}
