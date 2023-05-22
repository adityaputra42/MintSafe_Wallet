// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:logging/logging.dart';

// class ApiClient extends http.BaseClient {
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     Logger.root
//         .info("=======================REQUEST===========================");
//     // if ((PrefHelper.instance.token).isNotEmpty) {
//     //   request.headers
//     //       .addAll({"Authorization": 'Bearer ${PrefHelper.instance.token}'});
//     // }
//     Logger.root.info("${request.method} => ${request.url}");
//     Logger.root.info("${request.headers}");
//     return request.send().then((value) {
//       debugPrint("${value.statusCode} => ${value.reasonPhrase}");
//       return value;
//     }).catchError((err) async {
//       debugPrint(err.toString());
//       return http.StreamedResponse(
//           Stream.fromIterable([err.toString().codeUnits]), 500);
//     });
//   }

//   @override
//   Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
//     return super.get(url, headers: headers).then((value) {
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(value.body);
//       Logger.root
//           .info("==========================================================");
//       return value;
//     }).catchError((err) {
//      throw Exception(err.toString());
//     });
//   }

//   @override
//   Future<http.Response> post(Uri url,
//       {Map<String, String>? headers, body, Encoding? encoding}) {
//     return super
//         .post(url, headers: headers, body: body, encoding: encoding)
//         .then((value) {
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(value.body);
//       Logger.root
//           .info("==========================================================");
//       return value;
//     }).catchError((err) {
//      throw Exception(err.toString());
//     });
//   }

//   @override
//   Future<http.Response> put(Uri url,
//       {Map<String, String>? headers, body, Encoding? encoding}) {
//     return super
//         .put(url, headers: headers, body: body, encoding: encoding)
//         .then((value) {
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(value.body);
//       Logger.root
//           .info("==========================================================");
//       return value;
//     }).catchError((err) {
//      throw Exception(err.toString());
//     });
//   }

//   @override
//   Future<http.Response> patch(Uri url,
//       {Map<String, String>? headers, body, Encoding? encoding}) {
//     return super
//         .patch(url, headers: headers, body: body, encoding: encoding)
//         .then((value) {
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(value.body);
//       Logger.root
//           .info("==========================================================");
//       return value;
//     }).catchError((err) {
//       throw Exception(err.toString());
//     });
//   }

//   @override
//   Future<http.Response> delete(Uri url,
//       {Map<String, String>? headers, body, Encoding? encoding}) {
//     return super
//         .delete(url, headers: headers, body: body, encoding: encoding)
//         .then((value) {
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(value.body);
//       Logger.root
//           .info("==========================================================");
//       return value;
//     }).catchError((err) {
//   throw Exception(err.toString());
//     });
//   }

//   Future<dynamic> multiPart(http.MultipartRequest request) async {
//     Map<String, dynamic> responseJson;
//     try {
//       final response = await request.send();
//       Logger.root
//           .info("=======================REQUEST===========================");

//       Logger.root.info("${request.method} => ${request.url}");
//       Logger.root.info("${request.headers}");
//       final res = await http.Response.fromStream(response);
//       Logger.root
//           .info("=======================RESPONSE===========================");
//       Logger.root.info(res.body);
//       Logger.root
//           .info("==========================================================");
//       if (res.statusCode >= 200 && res.statusCode < 500) {
//         responseJson = res.body as Map<String, dynamic>;
//         return responseJson;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
