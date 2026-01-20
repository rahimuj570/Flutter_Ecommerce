import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_details_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductCardModel> _productCardList = [];
  final List<ProductCardModel> _popularProductCardList = [];
  final List<ProductCardModel> _newProductCardList = [];
  final List<ProductCardModel> _specialProductCardList = [];
  final String popularCategoryId = '67c35af85e8a445235de197b';
  final String newCategoryId = "67c7bec4623a876bc4766fea";
  final String specialProducts = '67c35b395e8a445235de197e';

  int count = 10;
  int? pageNo = 1;
  int? _lastPage = 1;

  int productQuantity = 0;

  bool _isFethingProductCardList = false;
  bool _isFethingMore = false;
  bool _isFetchingProductById = false;
  ProductDetailsModel? _productDetailsModel;

  List<ProductCardModel> get getProductCardList => _productCardList;
  List<ProductCardModel> get getPopularProductCardList =>
      _popularProductCardList;
  List<ProductCardModel> get getNewProductCardList => _newProductCardList;
  List<ProductCardModel> get getSpecialProductCardList =>
      _specialProductCardList;

  ProductDetailsModel? get getProductById => _productDetailsModel;
  bool get getIsFetchingProductCardList => _isFethingProductCardList;
  bool get getIsFetchingMore => _isFethingMore;
  int get getPageNo => pageNo!;
  int get getLastPage => _lastPage!;
  bool get getIsFatchingProductById => _isFetchingProductById;

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
      if (categoryId == popularCategoryId) {
        _popularProductCardList.add(ProductCardModel.fromJson(json));
      } else if (categoryId == newCategoryId) {
        _newProductCardList.add(ProductCardModel.fromJson(json));
      } else if (categoryId == specialProducts) {
        _specialProductCardList.add(ProductCardModel.fromJson(json));
      } else {
        _productCardList.add(ProductCardModel.fromJson(json));
      }
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

  Future<void> fetchProductById(String id) async {
    _isFetchingProductById = true;
    notifyListeners();
    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.fetchProductById(id),
    );
    _productDetailsModel = ProductDetailsModel.fromJson(
      responseModel.responseData,
    );
    productQuantity = _productDetailsModel!.quantity;
    _isFetchingProductById = false;
    notifyListeners();
  }

  //Cart Logic Start
  bool _isAddToCartPrcessing = false;
  NetworkResponseModel? _responseModel;
  bool get getIsAddCartProcesing => _isAddToCartPrcessing;
  NetworkResponseModel get getResponseModel => _responseModel!;

  Future<void> addToCart(Map<String, dynamic> body) async {
    _isAddToCartPrcessing = true;
    notifyListeners();
    _responseModel = await getNetworkCaller().postCall(
      body: body,
      uri: UriList.cart,
    );
    _isAddToCartPrcessing = false;
    notifyListeners();
  }
}
