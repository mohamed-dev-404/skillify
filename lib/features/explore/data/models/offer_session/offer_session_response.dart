class OfferSessionResponse {
  const OfferSessionResponse({
    this.message,
  });

  factory OfferSessionResponse.fromJson(Map<String, dynamic> json) {
    return OfferSessionResponse(
      message: json['message'] as String?,
    );
  }

  final String? message;
}
