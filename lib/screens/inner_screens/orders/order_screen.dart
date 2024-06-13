import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/models/order_model.dart';
import 'package:user_zeebe_app/providers/order_provider.dart';
import 'package:user_zeebe_app/screens/inner_screens/orders/orders_widget.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';
import 'package:user_zeebe_app/widgets/empty_widget_bag.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({super.key});

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const TitleTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: FutureBuilder<List<OrdersModelAdvanced>>(
          future: ordersProvider.fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SelectableText(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
              return EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                subtitle: "",
                buttonText: "Shop now",
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(
                      ordersModelAdvanced: ordersProvider.getOrders[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                    // thickness: 8,
                    // color: Colors.red,
                    );
              },
            );
          },
        ));
  }
}
