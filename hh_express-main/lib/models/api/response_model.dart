

class ApiResponse<T> {
  ApiResponse({
    this.error,
    required this.success,
    this.data,
    this.message,
  });
  final bool success;
  final T? data;
  final dynamic message;
  final String? error;

  static ApiResponse<dynamic> fromJson(Map<String, dynamic> json) {
    return ApiResponse<dynamic>(
      data: json['data'] ?? {},
      message: json['message'] ?? 'null',
      success: json['success'] != null ? json['success'] as bool : false,
      error: json['error'] ?? 'null',
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'ApiResponse(success: $success, data: $data, error: $error, messages: $message)';
  }

  static final unknownError = ApiResponse(
    data: {},
    error: 'Unknown Error',
    message: 'Unknown Error',
    success: false,
  );
}
