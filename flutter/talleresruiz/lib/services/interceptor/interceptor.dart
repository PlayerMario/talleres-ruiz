import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/services/localstorage/localstorage_service.dart';

import '../../main.dart';

class ApiConstants {
  //static String baseUrl = "http://localhost:8080";
  static String baseUrl = "http://10.0.2.2:8080";
}

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
    // El interceptor con los encabezados sobre JSON se añade si no está incluido en la lista
    if (interceptors
        .where((element) => element is HeadersApiInterceptor)
        .isEmpty) interceptors..add(HeadersApiInterceptor());
    _httpClient = InterceptedClient.build(interceptors: interceptors);
  }

  Future<dynamic> get(String url) async {
    //try {
    Uri uri = Uri.parse(ApiConstants.baseUrl + url);
    final response = await _httpClient.get(uri);
    //var responseJson = response;
    //return responseJson;
    print("GET INTERCEPTOR");
    return _response(response);
    /*} on SocketException catch (ex) {
      throw FetchDataException('No internet connection: ${ex.message}');
    }*/
  }

  Future<dynamic> post(String url, dynamic body) async {
    //try {
    Uri uri = Uri.parse(ApiConstants.baseUrl + url);
    final response = await _httpClient.post(uri, body: jsonEncode(body));
    //var responseJson = response;
    //return responseJson;
    print("POST INTERCEPTOR");
    return _response(response);
    /*} on Exception catch(ex) {
      throw ex;
    }*/
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 204:
        return;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
        // Así sacamos el mensaje del JSON devuelto por el API
        //String message = jsonDecode(utf8.decode(response.bodyBytes))['message'];
        //throw AuthenticationException(message);

        // Así devolvemos un mensaje "genérico"
        throw AuthenticationException("You have entered an invalid username or password");
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 404:
        throw NotFoundException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final message;
  final _prefix;

  CustomException([this.message, this._prefix]);

  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class AuthenticationException extends CustomException {
  AuthenticationException([message]) : super(message, "");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "");
}

class AuthorizationInterceptor implements InterceptorContract {
  late LocalStorageService _localStorageService;

  AuthorizationInterceptor() {
    //_localStorageService = getIt<LocalStorageService>();
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
        Navigator.of(GlobalContext.ctx).push<void>(LoginForm.route());
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
