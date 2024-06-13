import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/providers/cart_provider.dart';
import 'package:user_zeebe_app/providers/product_provider.dart';
import 'package:user_zeebe_app/screens/inner_screens/address_details.dart';

import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key, required this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 2, color: Color.fromARGB(255, 137, 127, 127)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitleTextWidget(
                            label:
                                "Total (${cartProvider.getCartitems.length} products/${cartProvider.getQty()} items)")),
                    SubtitleTextWidget(
                      label:
                          "${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)}\Rs",
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(AddDeliveryAddress.routeName);
                  await function();
                },
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
