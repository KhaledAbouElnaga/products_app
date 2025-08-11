import 'dart:convert';
import 'package:beggining/Api/api.dart';
import 'package:beggining/models/get_products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class GetProductsController extends GetxController {
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxString controller = ''.obs;
  RxBool isLoading = false.obs;
  final dio = Dio();
  //CANNOT BE FINAL CUZ IT WILL BE ALWAYS CHANGED
  //IT WON'T AFFECT THE UI SO, WE WON'T ADD .obs // THERE IS NO NEED TO FOLLOW IT
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    getProductsFn();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  Future<List<ProductModel>> getProductsFn() async {
    isLoading.value = true;
    try {
      final response = await dio.get(
        Api.prodects,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
        ),
      );
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Raw Response Data: ${response.data}');

      final products = getProductsModelFromJson(jsonEncode(response.data));
      return filteredProducts.value = products;
    } catch (e) {
      throw Exception('FAILED TO BRING THE PRODUCT: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String userInput) {
    _debounce?.cancel();
    _debounce = Timer(
      Duration(milliseconds: 800),
      () => searchProductFn(userInput),
    );
  }

  Future<List<ProductModel>> searchProductFn(String controller) async {
    isLoading.value = true;
    try {
      final url = "${Api.filterByTitle}$controller";

      final response = await dio.get(url);
      final products = getProductsModelFromJson(jsonEncode(response.data));

      filteredProducts.value = products;
      return products;
    } catch (e) {
      throw Exception('FAILED TO BRING THE PRODUCT: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
