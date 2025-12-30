import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';

class SignupProvider extends ChangeNotifier {
  bool isProgress = false;
  bool get getProgress => isProgress;
  NetworkResponseModel? _res;
  NetworkResponseModel get getResponse => _res!;
  Future<bool> signUp(Map<String, dynamic> body) async {
    isProgress = true;
    notifyListeners();
    _res = await getNetworkCaller().postCall(uri: UriList.signup, body: body);
    isProgress = false;
    notifyListeners();
    return _res!.isSuccess;
  }
}
