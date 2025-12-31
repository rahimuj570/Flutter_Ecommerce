import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/verify_request_model.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _isVerfyProcessing = false;
  NetworkResponseModel? _responseModel;

  bool get getIsVerifyProcessing => _isVerfyProcessing;
  NetworkResponseModel get getResponseModel => _responseModel!;

  Future<void> verifyOtp(VerifyRequestModel model) async {
    _isVerfyProcessing = true;
    notifyListeners();
    _responseModel = await getNetworkCaller().postCall(
      uri: UriList.verify,
      body: model.toJson(),
    );

    _isVerfyProcessing = false;
    notifyListeners();
  }
}
