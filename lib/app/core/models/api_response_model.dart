import 'package:dio/dio.dart';

class ApiResponse<T> {
  late T data;
  late DioException error;
  bool hasError;
  bool hasData;
  bool hasLoading = false;

  ApiResponse.complete(this.data)
      : hasError = false,
        hasData = true;

  ApiResponse.error(this.error)
      : hasError = true,
        hasData = false;

  ApiResponse.loading()
      : hasLoading = true,
        hasError = false,
        hasData = false;
}
