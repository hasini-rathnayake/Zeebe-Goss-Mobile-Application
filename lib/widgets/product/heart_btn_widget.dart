import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/providers/wishlist_provider.dart';
import 'package:user_zeebe_app/services/my_app_methods.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.colors = Colors.transparent,
    this.size = 20,
    required this.productId,
    // this.isInWishlist = false,
  });
  final Color colors;
  final double size;
  final String productId;
  // final bool? isInWishlist;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistsProvider = Provider.of<WishlistProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: widget.colors,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(elevation: 10),
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          try {
            // wishlistsProvider.addOrRemoveFromWishlist(
            //   productId: widget.productId,
            // );
            if (wishlistsProvider.getWishlists.containsKey(widget.productId)) {
              await wishlistsProvider.removeWishlistItemFromFirestore(
                wishlistId: wishlistsProvider
                    .getWishlists[widget.productId]!.wishlistId,
                productId: widget.productId,
              );
            } else {
              await wishlistsProvider.addToWishlistFirebase(
                productId: widget.productId,
                context: context,
              );
            }
            await wishlistsProvider.fetchWishlist();
          } catch (e) {
            await MyAppMethods.showErrorOrWarningDialog(
              context: context,
              subtitle: e.toString(),
              fct: () {},
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        },
        icon: _isLoading
            ? const CircularProgressIndicator()
            : Icon(
                wishlistsProvider.isProdinWishlist(
                  productId: widget.productId,
                )
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: wishlistsProvider.isProdinWishlist(
                  productId: widget.productId,
                )
                    ? Colors.red
                    : Color.fromARGB(255, 87, 117, 139),
              ),
      ),
    );
  }
}
