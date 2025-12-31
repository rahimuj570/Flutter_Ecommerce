import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/core/models/logger_model.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:http/http.dart';

class NetworkCaller {
  final Map<String, String>? header;
  final VoidCallback onUnauthorized;

  NetworkCaller({required this.header, required this.onUnauthorized});

  //GET Action
  Future<NetworkResponseModel> getCall({required String uri}) async {
    Response response = await get(Uri.parse(uri), headers: header);
    LoggerModel(url: uri, statusCode: response.statusCode, body: response.body);

    Map<String, dynamic> responseData = jsonDecode(response.body);

    return NetworkResponseModel(
      isSuccess: responseData['status'] == 'success',
      statusCode: response.statusCode,
      message: responseData['msg'],
      responseData: responseData['data'],
    );
  }

  //POST Action
  Future<NetworkResponseModel> postCall({
    required String uri,
    required Map<String, dynamic> body,
  }) async {
    Response response = await post(
      Uri.parse(uri),
      body: jsonEncode(body),
      headers: header,
    );
    LoggerModel(
      url: uri,
      statusCode: response.statusCode,
      body: response.body,
    ).printLog();

    Map<String, dynamic> responseData = jsonDecode(response.body);

    return NetworkResponseModel(
      isSuccess: responseData['status'] == 'success',
      statusCode: response.statusCode,
      message: responseData['msg'],
      responseData: responseData['data'],
    );
  }
}
