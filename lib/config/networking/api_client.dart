// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mintsafe_wallet/config/networking/request_header.dart';

class ApiClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    log("=======================REQUEST===========================");
    request.headers.addAll(RequestHeaders().setHeaders());
    log("${request.method} => ${request.url}");
    log("${request.headers}");

    return request.send().then((value) {
      debugPrint("${value.statusCode} => ${value.reasonPhrase}");
      return value;
    }).catchError((err) async {
      debugPrint(err.toString());
      return http.StreamedResponse(
          Stream.fromIterable([err.toString().codeUnits]), 500);
    });
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return super.get(url, headers: headers).then((value) {
      log("=======================RESPONSE===========================");
      log(value.body);
      log("==========================================================");
      return value;
    }).catchError((err) {
      log('Error: $err'); // Prints 401.
    }, test: (error) {
      return error is int && error >= 400;
    });
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return super
        .post(url, headers: headers, body: body, encoding: encoding)
        .then((value) {
      log("=======================RESPONSE===========================");
      log(value.body);
      log("==========================================================");
      return value;
    }).catchError((err) {
      log('Error: $err'); // Prints 401.
    }, test: (error) {
      return error is int && error >= 400;
    });
  }
}
