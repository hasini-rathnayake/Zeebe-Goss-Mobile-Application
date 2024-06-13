import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/providers/cart_provider.dart';
import 'package:user_zeebe_app/providers/product_provider.dart';
import 'package:user_zeebe_app/providers/viewed_prod_provider.dart';
import 'package:user_zeebe_app/screens/inner_screens/products_details.dart';
import 'package:user_zeebe_app/services/my_app_methods.dart';
import 'package:user_zeebe_app/widgets/product/heart_btn_widget.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });
  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () async {
                viewedProdProvider.addViewedProd(
                    productId: getCurrProduct.productId);
                await Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routName,
                  arguments: getCurrProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TitleTextWidget(
                            label: getCurrProduct.productTitle,
                            fontSize: 18,
                            maxlines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                            productId: getCurrProduct.productId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SubtitleTextWidget(
                            label: "${getCurrProduct.productPrice}\ Rs",
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.lightBlue,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () async {
                                if (cartProvider.isProdinCart(
                                    productId: getCurrProduct.productId)) {
                                  return;
                                }
                                try {
                                  await cartProvider.addToCartFirebase(
                                      productId: getCurrProduct.productId,
                                      qty: 1,
                                      context: context);
                                } catch (e) {
                                  await MyAppMethods.showErrorOrWarningDialog(
                                    context: context,
                                    subtitle: e.toString(),
                                    fct: () {},
                                  );
                                }
                                // if (cartProvider.isProdinCart(
                                //     productId: getCurrProduct.productId)) {
                                //   return;
                                // }
                                // cartProvider.addProductToCart(
                                //     productId: getCurrProduct.productId);
                              },
                              splashColor: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  cartProvider.isProdinCart(
                                          productId: getCurrProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
  }
}
