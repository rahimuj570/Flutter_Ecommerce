import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/reviews/data/models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  bool _isFeching = false;
  NetworkResponseModel? _responseModel;
  final List<ReviewModel> _reviewList = [];
  int _totalReview = 0;

  int get getReviewCount => _totalReview;
  bool get getIsCartFetching => _isFeching;
  NetworkResponseModel get getResponseModel => _responseModel!;
  List<ReviewModel> get getReviewList => _reviewList;

  Future<void> fetchReviews(String productId) async {
    _reviewList.clear();
    _responseModel = null;
    _isFeching = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().getCall(
      uri: UriList.getReview(productId),
    );
    List<dynamic> jsonList = _responseModel!.responseData['results'];
    for (Map<String, dynamic> json in jsonList) {
      _reviewList.add(ReviewModel.fromJson(json));
    }
    _totalReview = _responseModel!.responseData['total'];
    _isFeching = false;
    notifyListeners();
  }
}
