class ApiResponse<T> {
  final bool isLoading;
  final T? data;
  final String? error;

  ApiResponse({this.isLoading = false, this.data, this.error});

  ApiResponse<T> loading() => ApiResponse<T>(isLoading: true);

  ApiResponse<T> success(T data) => ApiResponse<T>(data: data);

  ApiResponse<T> failure(String error) => ApiResponse<T>(error: error);
}
