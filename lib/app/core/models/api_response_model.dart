class ApiResponse<T> {
  late T data;
  late Exception error;
  bool hasError;
  bool hasData;
  bool hasLoading = false;

  bool get isDioException => hasError && error.toString().toLowerCase().contains('dio');

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
