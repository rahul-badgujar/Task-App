import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task_app/models/data_models/tag_model.dart';
import 'package:task_app/services/api/exception/api_exceptions.dart';

class HttpRequester {
  HttpRequester._privateConstructor();
  static final HttpRequester _instance = HttpRequester._privateConstructor();
  factory HttpRequester() {
    return _instance;
  }

  static const String apiUrl = "https://sigmatenant.com/mobile/tags";

  Future<http.Response> fetchData() async {
    try {
      final http.Response response = await http.get(apiUrl);
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        if (response.body.isEmpty)
          throw EmptyApiResultException();
        else {
          return response;
        }
      } else {
        _handleExceptions(statusCode);
      }
    } on Exception catch (exception) {
      if (exception is SocketException)
        print(ConnectionException().toString());
      else if (exception is ApiException) print(exception.toString());
    }
    return null;
  }

  void _handleExceptions(int statusCode) {
    print("Error in Fetching Data : " + statusCode.toString());
    final int errorType =
        statusCode % 100; // depeding on Code Type, get Excpetion type
    if (errorType == 3)
      throw RedirectionalApiException();
    else if (errorType == 4)
      throw ClientSideErrorApiException();
    else if (errorType == 5)
      throw ServerSideApiException();
    else
      throw UnknownApiException();
  }
}
