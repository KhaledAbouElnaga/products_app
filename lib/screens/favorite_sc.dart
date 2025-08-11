import 'package:beggining/controllers/favorite_conroller.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteSc extends StatelessWidget {
  final String? proTitle;
  final int? proSubTitle;
  final Image? proImage;

  const FavoriteSc({
    super.key,
    this.proTitle,
    this.proSubTitle,
    this.proImage,
  });

  @override
  Widget build(BuildContext context) {
    final FavoriteConroller favoriteConroller = Get.find();
    return Scaffold(
      backgroundColor: ColorFactory.background,
      body: Obx(() {
        return Expanded(
          child: ListView.builder(
              itemCount: favoriteConroller.favoriteList.length,
              itemBuilder: (context, index) {
                final favoritProduct = favoriteConroller.favoriteList[index];
                return ListTile(
                  title: Text(
                    favoritProduct.title ?? 'TITLE',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "\$${favoritProduct.price ?? 'PRICE'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (favoritProduct.images != null &&
                              favoritProduct.images!.isNotEmpty)
                          ? favoritProduct.images!.first
                          : 'https://via.placeholder.com/150',
                    ),
                  ),
                  trailing: GestureDetector(
                    child: Icon(
                      Icons.remove_circle_sharp,
                      color: ColorFactory.alertError,
                    ),
                    onTap: () => favoriteConroller.removeFromFavorite(
                      favoritProduct,
                    ),
                  ),
                );
              }),
        );
      }),
    );
  }
}
