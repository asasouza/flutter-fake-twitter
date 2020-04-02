// dart
import 'dart:convert';
// packages
import 'package:http/http.dart' as http;

class HttpHelper{
  static Future<http.Response> post(
    url, {
    Map<String, dynamic> body,
    Map<String, String> headers = const {},
    String token
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
    url, {
    Map<String, dynamic> body,
    Map<String, String> headers = const {},
    String token,
  }) async {
    print(token);
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
}
