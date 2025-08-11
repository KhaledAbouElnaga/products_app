import 'package:beggining/controllers/auth_controller.dart';
import 'package:beggining/controllers/get_products_controller.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:beggining/models/get_products_model.dart';
import 'package:beggining/widgets/circular_progress_indicator.dart';
import 'package:beggining/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsSc extends StatelessWidget {
  const ProductsSc({super.key});

  @override
  Widget build(BuildContext context) {
    final getProductsController = Get.find<GetProductsController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: ColorFactory.background,
      appBar: AppBar(
        backgroundColor: ColorFactory.background,
        //wile scroling
        surfaceTintColor: ColorFactory.background,
        leading: IconButton(
          onPressed: () {
            authController.logOut();
            Get.offAllNamed("/signin");
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: _SearchBarWZInputTextField(
          controller: getProductsController,
        ),
      ),
      body: Center(
        child: Obx(
          () => getProductsController.isLoading.value
              ? CircularProgressIndicatorClass(
                  circularProgressIndicator: CircularProgressIndicator(),
                ).cPI()
              : getProductsController.filteredProducts.isNotEmpty
                  ? GridView.builder(
                      padding: EdgeInsets.all(17),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 17,
                        crossAxisSpacing: 17,
                        // نسبة عرض العنصر إلى ارتفاعه (1.0 يعني العنصر مربع)
                        // childAspectRatio: 1.0,
                        // نسبة عرض العنصر إلى ارتفاعه داخل الشبكة.
                        // قيمة 1.0 تعني العرض = الارتفاع (عنصر مربع).
                        // لو القيمة أقل من 1، العنصر هيكون أطول من عرضه (عمودي أكثر).
                        // لو القيمة أكبر من 1، العنصر هيكون أعرض من ارتفاعه (أفقي أكثر).
                        childAspectRatio: 0.7,
                      ),
                      itemCount: getProductsController.filteredProducts.length,
                      itemBuilder: (context, indix) {
                        ProductModel product =
                            getProductsController.filteredProducts[indix];
                        return ProductWidget(product: product);
                      },
                    )
                  : const Text("No products found."),
        ),
      ),
    );
  }
}

class _SearchBarWZInputTextField extends StatelessWidget {
  final GetProductsController controller;

  const _SearchBarWZInputTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // pa: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorFactory.textFieldBoder,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: ColorFactory.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                // contentPadding: Edg,
                border: InputBorder.none,
                hintText: "BagBo...",
                hintStyle: TextStyle(
                  color: ColorFactory.black,
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: Icon(
                  Icons.tune,
                  color: ColorFactory.black,
                ),
              ),
              onChanged: (value) => controller.onSearchChanged(value),
            ),
          ),
        ],
      ),
    );
  }
}
