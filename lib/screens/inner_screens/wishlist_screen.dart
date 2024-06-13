import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/providers/wishlist_provider.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';
import 'package:user_zeebe_app/services/my_app_methods.dart';
import 'package:user_zeebe_app/widgets/empty_widget_bag.dart';
import 'package:user_zeebe_app/widgets/product/product_widget.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = "/WishlistScreen";
  const WishlistScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlists.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "Nothing in ur wishlist yet",
              subtitle: "add something and make me happy",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AssetsManager.shoppingCart,
                ),
              ),
              title: TitleTextWidget(
                  label: "Wishlist (${wishlistProvider.getWishlists.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Clear Wishlist?",
                      fct: () async {
                        await wishlistProvider.clearWishlistFromFirebase();
                        wishlistProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: wishlistProvider.getWishlists.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: wishlistProvider.getWishlists.length,
              crossAxisCount: 2,
            ),
          );
  }
}
