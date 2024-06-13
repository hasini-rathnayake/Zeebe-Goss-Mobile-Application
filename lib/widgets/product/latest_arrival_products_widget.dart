import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/models/products_model.dart';
import 'package:user_zeebe_app/providers/cart_provider.dart';
import 'package:user_zeebe_app/providers/viewed_prod_provider.dart';
import 'package:user_zeebe_app/screens/inner_screens/products_details.dart';
import 'package:user_zeebe_app/services/my_app_methods.dart';
import 'package:user_zeebe_app/widgets/product/heart_btn_widget.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewedProd(productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailsScreen.routName,
              arguments: productsModel.productId);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productsModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProdinCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                    productId: productsModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (e) {
                                await MyAppMethods.showErrorOrWarningDialog(
                                  context: context,
                                  subtitle: e.toString(),
                                  fct: () {},
                                );
                              }
                            },
                            icon: Icon(
                              cartProvider.isProdinCart(
                                productId: productsModel.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: "${productsModel.productPrice}\ Rs",
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
