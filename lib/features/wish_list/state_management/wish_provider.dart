import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';

class WishProvider extends ChangeNotifier {
  bool _isWishListFetching = false;
  final List<ProductCardModel> _wishList = [];
  NetworkResponseModel? _responseModel;

  List<ProductCardModel> get getWishList => _wishList;
  bool get getIsWishFetching => _isWishListFetching;
  NetworkResponseModel get getResponseModel => _responseModel!;

  Future<void> fetchWishList() async {
    _wishList.clear();
    _isWishListFetching = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().getCall(uri: UriList.wish);
    List<dynamic> temp = _responseModel!.responseData['results'];
    for (Map<String, dynamic> w in temp) {
      _wishList.add(
        ProductCardModel.fromJson(json: w['product'], wishIdParam: w['_id']),
      );
    }
    _isWishListFetching = false;
    notifyListeners();
  }

  bool _isWishStatusChanging = false;
  bool get getIsWishStatusChanging => _isWishStatusChanging;
  String _changingProductId = '1';
  String get getChangeingProductId => _changingProductId;

  Future<void> addToWish(String prouctId) async {
    _changingProductId = prouctId;
    _responseModel = null;
    _isWishStatusChanging = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().postCall(
      uri: UriList.wish,
      body: {"product": prouctId},
    );

    _isWishStatusChanging = false;
    notifyListeners();
  }

  Future<void> removeToWish(String wishId, String productId, int? index) async {
    _changingProductId = productId;
    _responseModel = null;
    _isWishStatusChanging = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().deleteCall(
      uri: '${UriList.wish}/$wishId',
    );

    if (index != null) {
      _wishList.removeAt(index);
    }
    _isWishStatusChanging = false;
    notifyListeners();
  }
}
