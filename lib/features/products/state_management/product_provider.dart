import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductCardModel> _productCardList = [];
  int count = 10;
  int? pageNo = 1;
  int? _lastPage = 1;

  bool _isFethingProductCardList = false;
  bool _isFethingMore = false;
  List<ProductCardModel> get getProductCardList => _productCardList;
  bool get getIsFetchingProductCardList => _isFethingProductCardList;
  bool get getIsFetchingMore => _isFethingMore;
  int get getPageNo => pageNo!;
  int get getLastPage => _lastPage!;

  Future<void> fethingProductCardListByCategry(
    int count,
    int page,
    String categoryId,
  ) async {
    if (page == 1) {
      _productCardList.clear();
      _isFethingProductCardList = true;
    } else {
      _isFethingMore = true;
    }
    notifyListeners();

    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.fetchProductCards(count, page, categoryId),
    );

    for (Map<String, dynamic> json in responseModel.responseData['results']) {
      _productCardList.add(ProductCardModel.fromJson(json));
    }

    if (page == 1) {
      _lastPage = responseModel.responseData['last_page'] ?? page + 1;
      _isFethingProductCardList = false;
    } else {
      _isFethingMore = false;
    }
    pageNo = page + 1;
    notifyListeners();
  }
}
