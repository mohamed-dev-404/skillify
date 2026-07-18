class RequestSessionResponse {
  const RequestSessionResponse({
    this.message,
  });

  factory RequestSessionResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return RequestSessionResponse(
      message: json['message'] as String?,
    );
  }

  final String? message;
}
