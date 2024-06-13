import 'package:flutter/material.dart';
import 'package:user_zeebe_app/models/viewed_prod_model.dart';
import 'package:uuid/uuid.dart';



class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProds {
    return _viewedProdItems;
  }

  void addViewedProd({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
          viewedProdId: const Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }
}


















/*import 'package:flutter/material.dart';
import 'package:user_zeebe_app/models/viewed_prod_model.dart';
import 'package:uuid/uuid.dart';


class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getviewedProdItems {
    return _viewedProdItems;
  }

  // bool isProductInWishlist({required String productId}) {
  // return _viewedProdItems.containsKey(productId);}

  void addProductToHistory({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );

    notifyListeners();
  }

  //void clearLocalWishlist() {
  //  _viewedProdItems.clear();
  // notifyListeners();
}*/