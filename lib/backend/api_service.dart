import 'package:beggining/Api/api.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiService {
  // Singleton pattern to ensure only one instance of ApiService exists
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  late final Dio _dio;
  final String baseUrl = Api().baseUrl;
  String? _token;

  ApiService._internal() {
    _token = GetStorage().read('access_token');
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    //this is an instance of Dio takes the BaseOptions object
    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          //as we did in Postman.
          options.headers['Authorization'] = "Bearer $_token";
          return handler.next(options);
        },
        onError: (error, handler) => handler.next(
          error,
        ),
      ),
    );
  }

  //queryParameters بـ يستخدموا في GET request علشان تطلب بيانات من غير ما تبعت Body.
  //queryParameters takes the info from the url

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      throw Exception('Failed to GET data: $e');
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw Exception('Failed to POST data: $e');
    }
  }
}
