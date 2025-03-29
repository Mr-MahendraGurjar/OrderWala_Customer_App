import 'dart:convert';
import 'dart:developer';

import 'package:activeitzone/app_config.dart';
import 'package:activeitzone/helpers/main_helpers.dart';
import 'package:activeitzone/helpers/shared_value_helper.dart';
import 'package:activeitzone/middlewares/group_middleware.dart';
import 'package:activeitzone/middlewares/middleware.dart';
import 'package:activeitzone/repositories/aiz_api_response.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<http.Response> get(
      {required String url,
      Map<String, String>? headers,
      Middleware? middleware,
      GroupMiddleware? groupMiddleWare}) async {
    Uri uri = Uri.parse(url);
    Map<String, String>? headerMap = commonHeader;
    headerMap.addAll(currencyHeader);
    if (headers != null) {
      headerMap.addAll(headers);
    }
    log('====================================================================================================================');
    log('URL -> $url');
    log('HEADER -> $headers');
    var response = await http.get(uri, headers: headerMap);
    log('final Response:------> ${response.body}');
    log('====================================================================================================================');
    return AIZApiResponse.check(response, middleware: middleware, groupMiddleWare: groupMiddleWare);
  }

  static Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      required String body,
      Middleware? middleware,
      GroupMiddleware? groupMiddleWare}) async {
    log('====================================================================================================================');
    log('URL -> $url');
    log('HEADER -> $headers');
    log('BODY -> $body');
    Uri uri = Uri.parse(url);
    Map<String, String>? headerMap = commonHeader;
    headerMap.addAll(currencyHeader);
    if (headers != null) {
      headerMap.addAll(headers);
    }
    var response = await http.post(uri, headers: headerMap, body: body);
    log('final Response:------> ${response.body}');
    log('====================================================================================================================');
    return AIZApiResponse.check(response, middleware: middleware, groupMiddleWare: groupMiddleWare);
  }

  // static Future<http.Response> delete(
  //     {required String url,
  //     Map<String, String>? headers,
  //     Middleware? middleware,
  //     GroupMiddleware? groupMiddleWare}) async {
  //   Uri uri = Uri.parse(url);
  //   Map<String, String>? headerMap = commonHeader;
  //   headerMap.addAll(currencyHeader);
  //   if (headers != null) {
  //     headerMap.addAll(headers);
  //   }
  //   var response = await http.delete(uri, headers: headerMap);
  //   log('Response:------> ${response.body}');
  //   return AIZApiResponse.check(response, middleware: middleware, groupMiddleWare: groupMiddleWare);
  // }

  static Future<http.Response> delete(
      {required String url,
      Map<String, String>? headers,
      Middleware? middleware,
      GroupMiddleware? groupMiddleWare}) async {
    Uri uri = Uri.parse(url);
    Map<String, String>? headerMap = commonHeader;
    headerMap.addAll(currencyHeader);
    if (headers != null) {
      headerMap.addAll(headers);
    }

    // Log request details
    log('DELETE Request:');
    log('URL: $url');
    log('Headers: ${JsonEncoder.withIndent('  ').convert(headerMap)}');

    var response = await http.delete(uri, headers: headerMap);

    // Log response details
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${JsonEncoder.withIndent('  ').convert(json.decode(response.body))}');

    return AIZApiResponse.check(response, middleware: middleware, groupMiddleWare: groupMiddleWare);
  }
}
