import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/consts/app_constants.dart';
import 'package:user_zeebe_app/providers/product_provider.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';
import 'package:user_zeebe_app/widgets/app_name_text.dart';
import 'package:user_zeebe_app/widgets/product/ctg_rounded_widget.dart';
import 'package:user_zeebe_app/widgets/product/latest_arrival_products_widget.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart1,
          ),
        ),
        title: const AppNameTextWidget(fontSize: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(50),
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      // alignment: Alignment.center,
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.red, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productsProvider.getProducts.isNotEmpty,
                child: const TitleTextWidget(label: "Latest arrival"),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productsProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsProvider.getProducts.length < 10
                          ? productsProvider.getProducts.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productsProvider.getProducts[index],
                            child: const LatestArrivalProductsWidget());
                      }),
                ),
              ),
              const TitleTextWidget(label: "Categories"),
              const SizedBox(
                height: 15.0,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    image: AppConstants.categoriesList[index].images,
                    name: AppConstants.categoriesList[index].name,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
