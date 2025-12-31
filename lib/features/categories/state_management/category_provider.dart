import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/categories/data/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final List<CategoryModel> _categoryList = [];
  bool _isFirstLoading = false;
  bool _isLoadingMore = false;

  int _currentPage = 1;
  int _lastPage = 1;
  int _categoryCount = 30;

  bool get getIsFirstLoadin => _isFirstLoading;
  bool get getIsLoadingMore => _isLoadingMore;
  List<CategoryModel> get getCategories => _categoryList;

  int get getCurrentPage => _currentPage;
  int get getLastPage => _lastPage;
  int get getCategoryCount => _categoryCount;

  Future<void> fetchFirstTime({
    required int currentPage,
    required int categoryCount,
  }) async {
    _isFirstLoading = true;
    _categoryList.clear();
    _currentPage = currentPage;
    _categoryCount = categoryCount;
    notifyListeners();

    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.fetchCategories(
        postCount: categoryCount,
        pageNumber: currentPage,
      ),
    );

    _lastPage = responseModel.responseData['last_page'];

    for (Map<String, dynamic> json in responseModel.responseData['results']) {
      _categoryList.add(CategoryModel.fromJson(json));
    }
    _isFirstLoading = false;
    notifyListeners();
  }

  Future<List<CategoryModel>> fetchMore() async {
    List<CategoryModel> categories = [];
    _currentPage++;
    if (_currentPage <= _lastPage) {
      print('sssssssssssssssssss$_currentPage');
      _isLoadingMore = true;
      notifyListeners();

      NetworkResponseModel responseModel = await getNetworkCaller().getCall(
        uri: UriList.fetchCategories(
          postCount: _categoryCount,
          pageNumber: _currentPage,
        ),
      );

      for (Map<String, dynamic> json in responseModel.responseData['results']) {
        categories.add(CategoryModel.fromJson(json));
      }
      _isLoadingMore = false;
      notifyListeners();
    }
    return categories;
  }
}
