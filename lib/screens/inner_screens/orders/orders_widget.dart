import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:user_zeebe_app/models/order_model.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({
    Key? key,
    required this.ordersModelAdvanced,
  }) : super(key: key);
  final OrdersModelAdvanced ordersModelAdvanced;
  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25,
              width: size.width * 0.25,
              imageUrl: widget.ordersModelAdvanced.imageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitleTextWidget(
                          label: widget.ordersModelAdvanced.productTitle,
                          maxlines: 2,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 22,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const TitleTextWidget(
                        label: 'Price:  ',
                        fontSize: 15,
                      ),
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "${widget.ordersModelAdvanced.price} \Rs",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SubtitleTextWidget(
                    label: "Qty:${widget.ordersModelAdvanced.quantity}",
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
