import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:injectable/injectable.dart';
import '../../main.dart';

/*class ApiConstants {
  //static String baseUrl = "http://localhost:8080";
  static String baseUrl = "http://10.0.2.2:8080";
}*/

class HeadersApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Accept"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

@Order(-10)
@singleton
class Interceptor {
  var _httpClient;

  Interceptor() {
    _httpClient =
        InterceptedClient.build(interceptors: [HeadersApiInterceptor()]);
  }

  Interceptor.withInterceptors(List<InterceptorContract> interceptors) {
    if (interceptors
        .where((element) => element is HeadersApiInterceptor)
        .isEmpty) interceptors..add(HeadersApiInterceptor());
    _httpClient = InterceptedClient.build(interceptors: interceptors);
  }

  Future<dynamic> get(String url) async {
    Uri uri = Uri.parse(baseUrl + url);
    final response = await _httpClient.get(uri);
    return response;
  }

  Future<dynamic> post(String url, dynamic body) async {
    Uri uri = Uri.parse(baseUrl + url);
    final response = await _httpClient.post(uri, body: jsonEncode(body));
    return response;
  }

  Future<dynamic> put(String url, dynamic body) async {
    Uri uri = Uri.parse(baseUrl + url);
    final response = await _httpClient.put(uri, body: jsonEncode(body));
    return response;
  }

  Future<dynamic> delete(String url) async {
    Uri uri = Uri.parse(baseUrl + url);
    final response = await _httpClient.delete(uri);
    return response;
  }
}

class AuthorizationInterceptor implements InterceptorContract {
  late LocalStorageService _localStorageService;

  AuthorizationInterceptor() {
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      var token = await _localStorageService.getFromDisk("user_token");
      data.headers["Authorization"] = "Bearer " + token;
    } catch (e) {
      print(e);
    }

    return Future.value(data);
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401 || data.statusCode == 403) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(GlobalContext.ctx).push<void>(FormularioLogin.route());
      });
    }
    return Future.value(data);
  }
}

@Order(-10)
@singleton
class RestAuthenticatedClient extends Interceptor {
  RestAuthenticatedClient()
      : super.withInterceptors(
            List.of(<InterceptorContract>[AuthorizationInterceptor()]));
}
