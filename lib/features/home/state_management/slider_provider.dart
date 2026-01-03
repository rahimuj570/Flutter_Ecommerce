import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/home/data/models/slider_model.dart';

class SliderProvider extends ChangeNotifier {
  final List<SliderModel> _sliderList = [];
  bool isSliderFetching = false;
  List<SliderModel> get getSliderList => _sliderList;

  Future<void> fetchSlider() async {
    isSliderFetching = true;
    notifyListeners();

    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.fetchSlides,
    );
    List<dynamic> jsonList = responseModel.responseData['results'];
    for (Map<String, dynamic> json in jsonList) {
      _sliderList.add(SliderModel.fromJson(json));
    }

    isSliderFetching = false;
    notifyListeners();
  }
}
