import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'features/restaurant/presentation/pages/restaurant_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RestaurantBloc(
          repository: RestaurantRepositoryImpl(
            localDataSource: RestaurantLocalDataSource(),
          ),
        )..fetchRestaurants(),
        child: RestaurantListPage(),
      ),
    );
  }
}