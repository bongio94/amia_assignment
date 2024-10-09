class RandomDogImageResponse {
  final String message;
  final String status;

  RandomDogImageResponse({
    required this.message,
    required this.status,
  });

  factory RandomDogImageResponse.fromJson(Map<String, dynamic> data) {
    return RandomDogImageResponse(message: data['message']!, status: data['status']!);
  }
}
