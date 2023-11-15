// api_headers.dart

import 'package:dio/dio.dart';

class ApiHeaders {
  static Options getHeaders({
    String? token,
    Map<String, String>? additionalHeaders,
    bool isImageRequest = false,
  }) {
    Map<String, String> headers = {
      "Content-Type": isImageRequest ? "image/*" : "application/json",
    };

    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    if (additionalHeaders != null && additionalHeaders.isNotEmpty) {
      headers.addAll(additionalHeaders);
    }

    return Options(headers: headers);
  }
}
