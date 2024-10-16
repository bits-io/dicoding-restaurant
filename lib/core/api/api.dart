class Api {
  static final Dicoding dicoding = Dicoding();
}

class Dicoding {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';
  final String list = '/list';
  final String detail = '/detail/';
  final String search = '/search?q=';
}
