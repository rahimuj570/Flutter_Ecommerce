import 'dart:convert';

import 'package:flutter_ecommerce/app/setup_network_caller.dart';
import 'package:flutter_ecommerce/app/uri_list.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManagement {
  static const String _tokenKey = 'token';
  static const String _modelKey = 'model';

  static String? _token;
  static UserModel? _model;
  static String? get getToken => _token;
  static UserModel? get getUserModel => _model!;

  static Future<void> saveUser(String jwtToken, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, jwtToken);
    sharedPreferences.setString(_modelKey, jsonEncode(model.toJson()));
  }

  static Future<void> loadUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString(_tokenKey);
    _model = UserModel.fromJson(
      jsonDecode(sharedPreferences.getString(_modelKey)!),
    );
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey) != null &&
        !JwtDecoder.isExpired(sharedPreferences.getString(_tokenKey) ?? '');
  }

  static Future<void> cleatUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static Future<void> refetchUser() async {
    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      uri: UriList.userUpdate,
    );
    AuthManagement._model = UserModel.fromJson(responseModel.responseData);
  }
}
