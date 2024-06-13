import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/models/cart_model.dart';
import 'package:user_zeebe_app/providers/cart_provider.dart';
import 'package:user_zeebe_app/providers/product_provider.dart';
import 'package:user_zeebe_app/screens/cart/qnt_btm_sheet_widget.dart';
import 'package:user_zeebe_app/widgets/product/heart_btn_widget.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.productImage,
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitleTextWidget(
                                  label: getCurrProduct.productTitle,
                                  maxlines: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      cartProvider.removeOneItem(
                                        productId: getCurrProduct.productId,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  HeartButtonWidget(
                                    productId: getCurrProduct.productId,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SubtitleTextWidget(
                                label: "${getCurrProduct.productPrice}\ Rs",
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return QuantityBottomSheetWidget(
                                        cartModel: cartModel,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(IconlyLight.arrowDown2),
                                label: Text(
                                  "Qty: ${cartModel.quantity}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(width: 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
