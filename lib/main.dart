import 'package:beggining/controllers/auth_controller.dart';
import 'package:beggining/controllers/favorite_conroller.dart';
import 'package:beggining/controllers/get_products_controller.dart';
import 'package:beggining/screens/favorite_sc.dart';
import 'package:beggining/screens/forgetpass_sc.dart';
import 'package:beggining/screens/products_sc.dart';
import 'package:beggining/screens/signin_sc.dart';
import 'package:beggining/screens/signup_sc.dart';
import 'package:beggining/screens/splash_sc.dart';
import 'package:beggining/widgets/bottonNavigatorBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => GetProductsController(), fenix: true);
  Get.lazyPut(() => FavoriteConroller(), fenix: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return GetMaterialApp(
      title: "Auth App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: authController.isAuthenticated.value ? '/bottonNB' : '/',
      getPages: [
        GetPage(name: '/', page: () => SplashSc()),
        GetPage(name: "/signup", page: () => SignupSc()),
        GetPage(name: "/signin", page: () => SigninSc()),
        GetPage(name: "/forgetpass", page: () => ForgetpassSc()),
        GetPage(name: "/products", page: () => ProductsSc()),
        GetPage(name: "/favoriteSc", page: () => FavoriteSc()),
        GetPage(name: '/bottonNB', page: () => BottonnavigatorbarWidget())
      ],
    );
  }
}
