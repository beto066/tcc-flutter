import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/internal_server_error_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/services/auth_service.dart';
import 'dart:convert';

import 'package:tccflutter/stores/auth_store.dart';



class ApiService {
  String? _baseUrl;
  String? _token;

  static final ApiService _instance = ApiService._internal();

  ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  Future<http.Response> get(String endpoint, {Map<String, String> headers = const {}, Map<String, dynamic> queryParams = const {}}) async {
  String stringQueryParams = '';
    if (queryParams.isNotEmpty) {
      stringQueryParams = '?';
      var isFirst = true;

      queryParams.forEach((key, value) {
        if (!isFirst) {
          stringQueryParams += '&';
        }
        isFirst = false;

        stringQueryParams += '$key=$value';
      });
    }

    final url = Uri.parse('$baseUrl$endpoint$stringQueryParams');
    final allHeaders = {
      ...(await defaultHeaders),
      ...headers,
    };

    return _validateResponse(await http.get(url, headers: allHeaders));
  }

  Future<http.Response> post(String endpoint, {Object? data, Map<String, String> headers = const {}}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final body = jsonEncode(data);
    final allHeaders = {
      ...(await defaultHeaders),
      ...headers,
    };

    return _validateResponse(await http.post(url, headers: allHeaders, body: body));
  }

  String get baseUrl {
    return _baseUrl ??= dotenv.get('API_URL', fallback: 'http://localhost');
  }

  http.Response _validateResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: {
        return response;
      }
      case 201: {
        return response;
      }
      case 204: {
        return response;
      }
      case 400: {
        throw BadRequestException(response.body);
      }
      case 401: {
        AuthStore().logout();

        throw UnauthorizedException(response.body);
      }
      case 403: {
        throw UnauthorizedException(response.body);
      }
      case 500: {
        throw InternalServerErrorException('${jsonEncode(response.body)}, with statusCode: ${response.body}');
      }
      default: {
        throw InternalServerErrorException('${jsonEncode(response.body)}, with statusCode: ${response.body}');
      }
    }
  }

  Future<String?> get token async {
    return _token ??= await AuthService().getToken();
  }

  Future<Map<String, String>> get defaultHeaders async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await token ?? ''}',
    };
  }
}
