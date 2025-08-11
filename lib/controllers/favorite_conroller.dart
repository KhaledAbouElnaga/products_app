import 'package:beggining/models/get_products_model.dart';
import 'package:get/get.dart';

class FavoriteConroller extends GetxController {
  RxList<ProductModel> favoriteList = <ProductModel>[].obs;

  void favoriteListFn(ProductModel favoriteProduct) {
    if (favoriteList.contains(favoriteProduct)) {
      favoriteList.remove(favoriteProduct);
    } else {
      favoriteList.add(favoriteProduct);
    }
  }

  void removeFromFavorite(ProductModel favoriteProduct) {
    favoriteList.remove(favoriteProduct);
  }
}
