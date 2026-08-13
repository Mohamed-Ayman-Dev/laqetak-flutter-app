class ApiResponse {
  final dynamic responseData;
  final int? statusCode;

  const ApiResponse({required this.responseData, required this.statusCode});

  @override
  String toString() {
    return '''
ApiResponse(
  statusCode: $statusCode,
  responseData: $responseData,
)
''';
  }
}
