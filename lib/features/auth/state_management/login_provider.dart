import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/login_request_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginProcessing = false;
  bool get getIsLoginProcess => _isLoginProcessing;
  NetworkResponseModel? _responseModel;
  NetworkResponseModel get getNetWorkResponse => _responseModel!;

  Future<void> login(LoginRequestModel model) async {
    _isLoginProcessing = true;
    notifyListeners();
    _responseModel = await getNetworkCaller().postCall(
      uri: UriList.login,
      body: model.toJson(),
    );
    _isLoginProcessing = false;
    notifyListeners();
    if (_responseModel!.isSuccess) {
      AuthManagement.saveUser(
        _responseModel!.responseData['token'],
        UserModel.fromJson(_responseModel!.responseData['user']),
      );
    }
  }
}
