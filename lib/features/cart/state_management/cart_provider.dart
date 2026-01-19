import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/cart/data/models/cart_card_model.dart';

class CartProvider extends ChangeNotifier {
  bool _isCartFetching = false;
  NetworkResponseModel? _responseModel;
  List<CartCardModel> _cartList = [];

  bool get getIsCartFetching => _isCartFetching;
  NetworkResponseModel get getResponseModel => _responseModel!;
  List<CartCardModel> get getCartList => _cartList;

  Future<void> fetchCartList() async {
    _cartList.clear();
    _isCartFetching = true;
    notifyListeners();
    _responseModel = await getNetworkCaller().getCall(uri: UriList.cart);

    if (_responseModel!.isSuccess) {
      List<dynamic> res = _responseModel!.responseData['results'];
      for (Map<String, dynamic> cart in res) {
        _cartList.add(CartCardModel.fromJson(cart));
      }
    }

    _isCartFetching = false;
    notifyListeners();
  }

  int getTotalAmount() {
    int total = 0;
    for (CartCardModel cm in _cartList) {
      total += (cm.selectedQuantity * cm.price);
    }
    return total;
  }

  void cartIncreDecre({required cartIndex, required bool add}) async {
    if (add) {
      _cartList[cartIndex].selectedQuantity += 1;
    } else {
      _cartList[cartIndex].selectedQuantity -= 1;
    }
    await getNetworkCaller().patchCall(
      uri: UriList.updateCart(_cartList[cartIndex].id),
      body: {"quantity": _cartList[cartIndex].selectedQuantity.toString()},
    );
    notifyListeners();
  }
}
