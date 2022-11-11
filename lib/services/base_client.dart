import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:startupapplication/services/app_exceptions.dart';

class BaseClient {
  static const int Time_Out_Duration = 10;
  //Get request
  Future<dynamic> get(String baseUrl, String endPoint, dynamic headers) async {
    var uri = Uri.parse(baseUrl + endPoint);
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: Time_Out_Duration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      ApiNotResponding('Server Take Longer To Response', uri.toString());
    }
  }

  //post request
  Future<dynamic> post(
    String? baseUrl,
    String? endPoint,
    dynamic headers,
    dynamic payloadObj,
  ) async {
    var uri = Uri.parse(baseUrl! + endPoint!);
    var payload = payloadObj.toString();
    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Time_Out_Duration));
      print(response.statusCode);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      ApiNotResponding('Server Take Longer To Response', uri.toString());
    }
  }

  //put request

  Future<dynamic> put(
    String? baseUrl,
    String? endPoint,
    dynamic headers,
    dynamic payloadObj,
  ) async {
    var uri = Uri.parse(baseUrl! + endPoint!);
    var payload = payloadObj.toString();
    try {
      var response = await http
          .put(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Time_Out_Duration));
      print(response.statusCode);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      ApiNotResponding('Server Take Longer To Response', uri.toString());
    }
  }
  //delete request

  Future<dynamic> delete(
    String? baseUrl,
    String? endPoint,
  ) async {
    var uri = Uri.parse(baseUrl! + endPoint!);

    try {
      var response =
          await http.delete(uri).timeout(Duration(seconds: Time_Out_Duration));
      print(response.statusCode);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      ApiNotResponding('Server Take Longer To Response', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.body;
        return responseJson; //model ma return garne

      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:

      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:

      default:
        throw FetchDataException(
            "Error Occured With Code : ${response.statusCode}",
            response.request!.url.toString());
    }
  }
}
