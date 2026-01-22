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

  int? nextPage;
  int? prevPage;

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
      uri: UriList.getReview(productId, 1),
    );
    List<dynamic> jsonList = _responseModel!.responseData['results'];
    for (Map<String, dynamic> json in jsonList) {
      _reviewList.add(ReviewModel.fromJson(json));
    }

    nextPage = _responseModel!.responseData['next'];
    prevPage = _responseModel!.responseData['previous'];
    _totalReview = _responseModel!.responseData['total'];
    _isFeching = false;
    notifyListeners();
  }

  bool _isFetchingMore = false;
  bool get getIsFetchingMore => _isFetchingMore;
  Future<void> fetchMoreReviews(String productId) async {
    _responseModel = null;
    _isFetchingMore = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().getCall(
      uri: UriList.getReview(productId, nextPage!),
    );
    List<dynamic> jsonList = _responseModel!.responseData['results'];
    for (Map<String, dynamic> json in jsonList) {
      _reviewList.add(ReviewModel.fromJson(json));
    }
    _totalReview = _responseModel!.responseData['total'];
    _isFetchingMore = false;
    notifyListeners();
  }

  bool _isCreating = false;
  bool get getIsCreating => _isCreating;
  Future<void> createReview(ReviewModel model) async {
    _responseModel = null;
    _isCreating = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().postCall(
      uri: UriList.createReview,
      body: {
        "product": model.productId,
        "comment": model.comment,
        "rating": model.rating,
      },
    );

    _isCreating = false;
    notifyListeners();
  }

  bool _isDeleting = false;
  bool get getIsDeleting => _isDeleting;
  Future<void> deleteReview(String reviewId, int index) async {
    _responseModel = null;
    _isDeleting = true;
    notifyListeners();
    _responseModel = await getNetworkCaller().deleteCall(
      uri: UriList.deleteReview(reviewId),
    );
    _reviewList.removeAt(index);
    _isDeleting = false;
    notifyListeners();
  }

  bool _isUpdating = false;
  bool get getIsUpdating => _isUpdating;
  Future<void> updateReview(ReviewModel model, int index) async {
    _responseModel = null;
    _isUpdating = true;
    notifyListeners();

    _responseModel = await getNetworkCaller().patchCall(
      uri: UriList.deleteReview(model.reviewId),
      body: {"comment": model.comment, "rating": model.rating},
    );
    if (_responseModel!.isSuccess) {
      _reviewList[index].comment = model.comment;
      _reviewList[index].rating = model.rating;
    }
    _isUpdating = false;
    notifyListeners();
  }
}
