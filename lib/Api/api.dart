class Api {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1/';

  // to access the base URL outside this class
  String get baseUrl => _baseUrl;

  static const String creatUser = '${_baseUrl}users/';

  static const String logIn = '${_baseUrl}auth/login';

  static const String prodects = '${_baseUrl}products';

  static const String filterByTitle = '${_baseUrl}products/?title=';
}
