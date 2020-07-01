// dart
import 'dart:convert';
import 'dart:io';
//flutter
import 'package:flutter/foundation.dart';
// packages
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpHelper {
  static Future<http.Response> get(
    String url, {
    Map<String, String> headers = const {},
    String token,
  }) async {
    return http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": token != null ? "Bearer $token" : "",
        ...headers,
      },
    );
  }

  static Future<http.Response> post(
    String url, {
    Map<String, dynamic> body,
    Map<String, String> headers = const {},
    String token,
  }) async {
    return http.post(
      url,
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token != null ? "Bearer $token" : "",
        ...headers,
      },
    );
  }

  static Future<http.Response> put(
    String url, {
    Map<String, dynamic> body,
    Map<String, String> headers = const {},
    @required String token,
  }) async {
    return http.put(
      url,
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token != null ? "Bearer $token" : "",
        ...headers,
      },
    );
  }

  static Future<http.Response> uploadImage(
    String url,
    File file, {
    String fieldName = 'picture',
    String method = 'POST',
    @required String token,
  }) async {
    final request = http.MultipartRequest(method, Uri.parse(url));
    request.headers['Authorization'] = token != null ? "Bearer $token" : "";

    final mime = lookupMimeType(file.path).split('/');
    final image = await http.MultipartFile.fromPath(
      fieldName,
      file.path,
      contentType: MediaType(mime[0], mime[1]),
    );
    request.files.add(image);
    var response = await request.send();

    return http.Response.fromStream(response);
  }
}
