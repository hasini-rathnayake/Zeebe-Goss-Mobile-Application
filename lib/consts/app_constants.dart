import 'package:user_zeebe_app/models/category_models.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';

class AppConstants {
  static const String imageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Hampers",
      images: AssetsManager.hampers,
      name: "Hampers",
    ),
    CategoryModel(
      id: "Teddy",
      images: AssetsManager.teddy,
      name: "Teddy",
    ),
    CategoryModel(
      id: "Perfums",
      images: AssetsManager.perfums,
      name: "Perfums",
    ),
    CategoryModel(
      id: "Accessories",
      images: AssetsManager.jewellery,
      name: "Accessories",
    ),
    CategoryModel(
      id: "Flowers",
      images: AssetsManager.flowerbouquet,
      name: "Flowers",
    ),
    CategoryModel(
      id: "Clothes",
      images: AssetsManager.clothes,
      name: "Clothes",
    ),
    CategoryModel(
      id: "Electronic",
      images: AssetsManager.electronics,
      name: "Electronic",
    ),
  ];

  static String apiKey = "AIzaSyA9FM4egnx7enS02E8RqZBPfiMWDghC4KQ";
  static String appId = "1:665474023095:android:703a7d42aa1a102b11d732";
  static String messagingSenderId = "665474023095";
  static String projectId = "zeebe-goss-finalapp";
  static String storagebucket = "zeebe-goss-finalapp.appspot.com";
}
