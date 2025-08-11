import 'dart:convert';
import 'package:beggining/Api/api.dart';
import 'package:beggining/backend/api_service.dart';
import 'package:beggining/models/login_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final dio = Dio();
  late GetStorage _storage;
  late ApiService _apiService;

  //Rx to follow the user state if he is logged in or not.
  Rx<LogInModel?> user = (null as LogInModel?).obs;

  //to get the user token from the user(LogInModel) model.
  String? get token => user.value?.accessToken;
  RxBool isAuthenticated = false.obs;

  // ask about this later
  // String? token = user.value?.accessToken;

  AuthController() {
    _storage = GetStorage();
    _apiService = ApiService();
    _init();
  }

  void _init() {
    // This method is called when the controller is initialized.
    // It checks if the user is already logged in by reading from GetStorage.
    final userJson = _storage.read('user');
    if (userJson != null) {
      // If userJson is not null, it means the user is already logged in.
      user.value = logInModelFromJson(jsonEncode(userJson));
      isAuthenticated.value = true;
    } else {
      // If userJson is null, it means the user is not logged in.
      user.value = null;
      isAuthenticated.value = false;
    }
  }

  // Future<UserModel> creatUser(
  //     String name, String email, String password) async {
  //   try {
  //     final response = await dio.post(
  //       Api.creatUser,
  //       data: {
  //         'name': name,
  //         'email': email,
  //         "password": password,
  //         "avatar": "https://picsum.photos/800"
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json'
  //         },
  //       ),
  //     );
  //     return userModelFromJson(
  //       json.encode(response.data),
  //     );
  //   } catch (e) {
  //     throw Exception('FAILED TO CREATE USER: $e');
  //   }
  // }

  // Future<LogInModel> logInFn(String email, String password) async {
  //   try {
  //     final response = await dio.post(
  //       Api.logIn,
  //       data: {
  //         'email': email,
  //         "password": password,
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json'
  //         },
  //       ),
  //     );
  //     return logInModelFromJson(
  //       jsonEncode(response.data),
  //     );
  //   } catch (e) {
  //     throw Exception('FAILED TO CREATE USER: $e');
  //   }
  // }

  Future<void> logIn(String email, String password) async {
    try {
      final response = await _apiService.post(
        Api.logIn,
        data: {
          'email': email,
          "password": password,
        },
      );
      // Makes the model(user.value = LogInModel) take the data from the response.
      // to rememmber:  cuz user.value is an Rx variable so if i wanna equal it to something i have to use .value.
      user.value = logInModelFromJson(jsonEncode(response.data));
      print(response.data);
      //Makes an instance of the LogInModel.
      user.value?.copyWith(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
      );
      // Saves the accessToken and refreshToken in the storage.
      // key & value
      _storage.write('access_token', user.value?.accessToken);
      _storage.write('refresh_token', user.value?.refreshToken);
      // Saves the user data in the storage as a json string cuz GetStorage only accepts strings/int/double/bool.
      _storage.write('user', user.value?.toJson());
      isAuthenticated.value = true;
    } catch (e) {
      throw Exception('FAILED TO LOGIN: $e');
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      final response = await _apiService.post(
        Api.creatUser,
        data: {
          'name': name,
          'email': email,
          "password": password,
          "avatar": "https://picsum.photos/800"
        },
      );
      // Makes the model(user.value = LogInModel) take the data from the response.
      user.value = logInModelFromJson(jsonEncode(response.data));
      // Saves the accessToken and refreshToken in the storage.
      _storage.write('access_token', user.value?.accessToken);
      _storage.write('refresh_token', user.value?.refreshToken);
      // Saves the user data in the storage as a json string cuz GetStorage only accepts strings/int/double/bool.
      _storage.write('user', user.value?.toJson());
      isAuthenticated.value = true;
    } catch (e) {
      throw Exception('FAILED TO SIGNUP: $e');
    }
  }

  Future<void> logOut() async {
    try {
      // Clear the user data from the storage.
      await _storage.erase();
      // Set the user value to null and isAuthenticated to false.
      user.value = null;
      isAuthenticated.value = false;
    } catch (e) {
      throw Exception('FAILED TO LOGOUT: $e');
    }
  }
}
