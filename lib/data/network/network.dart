import 'package:config_env/data/network/interceptor/setting_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../di/service_di.dart';
import '../../domain/configs/base_url.dart';
import 'http_error.dart';

abstract class HttpAPI {
  BaseUrl get baseUrl;

  final HttpError _httpError = serviceDI.get();
  Dio get _dio => serviceDI.get(param1: baseUrl);

  @protected
  Future sendApiRequest(
      Method method, {
        Map<String, String>? headers,
        dynamic body,
        Map<String, dynamic> queryParameters = const {},
      }) async {
    bool haveConnection = await _connectedWithInternet();
    if (!haveConnection) _httpError.withOutInternet();
    var request = HttpRequest.newRequest(method,
        dio: _dio,
        body: body,
        queryParameters: queryParameters,
        headers: headers);
    try {
      Response rawResponse = await request.send();
      return rawResponse.data;
    } catch (e) {
      _httpError.handleError(e);
    }
  }

  Future<bool> _connectedWithInternet() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class HttpRequest {
  final Method method;
  Map<String, dynamic>? headers;
  var body;
  Map<String, dynamic> queryParameters;
  Dio dio;
  Options? options;

  HttpRequest(
      this.method, {
        required this.dio,
        Map<String, dynamic>? headers,
        this.body,
        this.queryParameters = const {},
        this.options,
      });

  factory HttpRequest.newRequest(
      Method method, {
        required Dio dio,
        Map<String, String>? headers,
        var body,
        Map<String, dynamic> queryParameters = const {},
        Options? options,
      }) {
    return HttpRequest(method,
        dio: dio,
        headers: headers,
        body: body,
        queryParameters: queryParameters,
        options: options);
  }

  void addQueries(Map<String, dynamic> queryParameters) =>
      this.queryParameters = queryParameters;

  void addQuery(String key, var value) {
    queryParameters[key] = value;
  }

  void addParams(var body) => this.body = body;

  void addParam(String key, var value) {
    body ??= {};
    body[key] = value;
  }

  Future<Response> send() async {
    Future<Response> response;
    if (method is POST) {
      response = dio.post(method.path,
          data: body, queryParameters: queryParameters, options: options);
    } else if (method is GET) {
      response = dio.get(method.path,
          queryParameters: queryParameters, options: options);
    } else if (method is PUT) {
      response = dio.put(method.path,
          data: body, queryParameters: queryParameters, options: options);
    } else if (method is DELETE) {
      response = dio.delete(method.path,
          data: body, queryParameters: queryParameters, options: options);
    } else if (method is PATCH) {
      response = dio.patch(method.path,
          data: body, queryParameters: queryParameters, options: options);
    } else {
      throw 'no support method ${method.runtimeType}';
    }
    return response;
  }
}

abstract class Method {
  String path;

  Method(this.path);

  void setPath(String key, String value) {
    path = path.replaceAll(key, value);
  }

  Method addPath(String path) {
    this.path += path;
    return this;
  }
}

class POST extends Method {
  POST(String url) : super(url);
}

class GET extends Method {
  GET(String url) : super(url);
}

class PUT extends Method {
  PUT(String url) : super(url);
}

class PATCH extends Method {
  PATCH(String url) : super(url);
}

class DELETE extends Method {
  DELETE(String url) : super(url);
}