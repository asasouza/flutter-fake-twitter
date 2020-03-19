// dart
import 'dart:convert';
// packages
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> post(
    url, {
    Map<String, dynamic> body,
    Map<String, String> headers = const {},
  }) async {
    return http.post(
      url,
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        ...headers,
      },
    );
  }
}
