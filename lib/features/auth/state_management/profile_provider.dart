import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isUpdating = false;
  bool get getIsUpdating => _isUpdating;
  NetworkResponseModel? _responseModel;
  NetworkResponseModel get getResponseModel => _responseModel!;

  Future<void> updateProfile(Map<String, dynamic> body) async {
    _isUpdating = true;
    _responseModel = null;
    notifyListeners();

    _responseModel = await getNetworkCaller().patchCall(
      uri: UriList.userUpdate,
      body: body,
    );

    if (_responseModel!.isSuccess) {
      AuthManagement.refetchUser();
    }

    _isUpdating = false;
    notifyListeners();
  }
}
