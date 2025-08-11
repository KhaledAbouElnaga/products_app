import 'package:beggining/controllers/favorite_conroller.dart';
import 'package:beggining/factory/assets_factory.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:beggining/models/get_products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final FavoriteConroller favoriteConroller = Get.find();
  bool isPresed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  image: NetworkImage(
                    (widget.product.images != null &&
                            widget.product.images!.isNotEmpty)
                        ? widget.product.images!.first
                        : 'IMAGE',
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AssetsFactory.notFound,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isPresed = !isPresed;
                        favoriteConroller.favoriteListFn(widget.product);
                      });
                    },
                    icon: Icon(
                      isPresed ? Icons.favorite : Icons.favorite_border,
                      color: isPresed
                          ? ColorFactory.alertError
                          : ColorFactory.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          widget.product.title ?? 'TITLE',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          widget.product.category?.name ?? 'NAME',
          style: const TextStyle(
            color: ColorFactory.textSecondary,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          "\$${widget.product.price ?? 'NAME'}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
