import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:telemed/Networking/APIJsend.dart';
import 'package:telemed/settings.dart';

class APIManager {
  Future<APIJsend> getAPI(
      {String? token,
      required String apiRoute,
      Map<String, dynamic>? param}) async {
    http.Client client = http.Client();
    var url = Uri.http(TelemedSettings.authority,
        TelemedSettings.unencodedPath + apiRoute, param);

    APIJsend apiJsend;
    APIstatus apiStatus;
    var data;
    String message;
    try {
      var response = await client.get(url,
          headers: TelemedSettings.getHttpHeaders(token: token));

      // Only required if url is redirected
      if (response.statusCode == 302 || response.statusCode == 307) {
        if (response.headers.containsKey("location")) {
          var getResponse = await client.get(
            Uri.parse(response.headers["location"]!),
            headers: TelemedSettings.getHttpHeaders(token: token),
          );
          response = getResponse;
        }
      }
      //

      apiJsend = _apiJsendResponse(response);
    } on SocketException {
      apiStatus = APIstatus.error;
      data = null;
      message = 'No Internet connection 😑';
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print('No Internet connection 😑');
    } on HttpException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Couldn't find the post 😱";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Couldn't find the post 😱");
    } on FormatException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Bad response format 👎";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Bad response format 👎");
    } on TimeoutException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Request took too long...";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Request took too long...");
    }
    client.close();
    return apiJsend;
  }

  Future<APIJsend> postAPI(
      {String? token, required String apiRoute, String? param}) async {
    http.Client client = http.Client();
    var url = Uri.http(TelemedSettings.authority,
        TelemedSettings.unencodedPath + apiRoute, {});

    APIJsend apiJsend;
    APIstatus apiStatus;
    var data;
    String message;
    try {
      var response = await client.post(url,
          headers: TelemedSettings.getHttpHeaders(token: token), body: param);

      // Only required if url is redirected
      if (response.statusCode == 302 || response.statusCode == 307) {
        if (response.headers.containsKey("location")) {
          var getResponse = await client.post(
              Uri.parse(response.headers["location"]!),
              headers: TelemedSettings.getHttpHeaders(token: token),
              body: param);
          response = getResponse;
        }
      }
      //

      apiJsend = _apiJsendResponse(response);
    } on SocketException {
      apiStatus = APIstatus.error;
      data = null;
      message = 'No Internet connection 😑';
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print('No Internet connection 😑');
    } on HttpException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Couldn't find the post 😱";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Couldn't find the post 😱");
    } on FormatException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Bad response format 👎";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Bad response format 👎");
    } on TimeoutException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Request took too long...";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Request took too long...");
    }
    client.close();
    return apiJsend;
  }

  Future<APIJsend> deleteAPI(
      {String? token,
      required String apiRoute,
      Map<String, dynamic>? param}) async {
    http.Client client = http.Client();
    var url = Uri.http(TelemedSettings.authority,
        TelemedSettings.unencodedPath + apiRoute, param);

    APIJsend apiJsend;
    APIstatus apiStatus;
    var data;
    String message;
    try {
      var response = await client.delete(url,
          headers: TelemedSettings.getHttpHeaders(token: token));

      // Only required if url is redirected
      if (response.statusCode == 302 || response.statusCode == 307) {
        if (response.headers.containsKey("location")) {
          var getResponse = await client.delete(
              Uri.parse(response.headers["location"]!),
              headers: TelemedSettings.getHttpHeaders(token: token),
              body: param);
          response = getResponse;
        }
      }
      //

      apiJsend = _apiJsendResponse(response);
    } on SocketException {
      apiStatus = APIstatus.error;
      data = null;
      message = 'No Internet connection 😑';
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print('No Internet connection 😑');
    } on HttpException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Couldn't find the post 😱";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Couldn't find the post 😱");
    } on FormatException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Bad response format 👎";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Bad response format 👎");
    } on TimeoutException {
      apiStatus = APIstatus.error;
      data = null;
      message = "Request took too long...";
      apiJsend =
          APIJsend.name(apiStatus: apiStatus, data: data, message: message);
      // print("Request took too long...");
    }
    client.close();
    return apiJsend;
  }

  APIJsend _apiJsendResponse(http.Response response) {
    APIJsend apiJsend;
    APIstatus apiStatus;
    var data;
    String message;
    switch (response.statusCode) {
      case 200:
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        apiStatus = APIstatus.success;
        data = jsonResponse;
        message = APIstatus.success.toString();
        apiJsend =
            APIJsend.name(apiStatus: apiStatus, data: data, message: message);
        return apiJsend;
      case 400:
        apiStatus = APIstatus.fail;
        data = response.body;
        message = response.body.toString();
        apiJsend =
            APIJsend.name(apiStatus: apiStatus, data: data, message: message);
        return apiJsend;

      // throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        apiStatus = APIstatus.fail;
        data = response.body;
        message = response.body.toString();
        apiJsend =
            APIJsend.name(apiStatus: apiStatus, data: data, message: message);
        return apiJsend;

      // throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        apiStatus = APIstatus.fail;
        data = response.body;
        message =
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}';
        apiJsend =
            APIJsend.name(apiStatus: apiStatus, data: data, message: message);
        return apiJsend;

      // throw FetchDataException(
      //     'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
