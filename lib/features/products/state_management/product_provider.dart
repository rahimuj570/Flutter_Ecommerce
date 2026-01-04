import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductCardModel> _productCardList = [];
  bool _isFethingProductCardList = false;

  List<ProductCardModel> get getProductCardList => _productCardList;
  bool get getIsFetchingProductCardList => _isFethingProductCardList;

  Future<void> fethingProductCardListByCategry(String categoryId) async {
    _productCardList.clear();
    _isFethingProductCardList = true;
    notifyListeners();

    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.fetchProductCards(30, 1, categoryId),
    );

    for (Map<String, dynamic> json in responseModel.responseData['results']) {
      _productCardList.add(ProductCardModel.fromJson(json));
    }

    _isFethingProductCardList = false;
    notifyListeners();
  }
}
