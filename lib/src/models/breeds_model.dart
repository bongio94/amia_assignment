class BreedsResponse {
  BreedsResponse({
    required this.message,
    required this.status,
  });

  final Map<String, List<String>> message;
  final String? status;

  BreedsResponse copyWith({
    Map<String, List<String>>? message,
    String? status,
  }) {
    return BreedsResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  factory BreedsResponse.fromJson(Map<String, dynamic> json) {
    return BreedsResponse(
      message: Map.from(json["message"]).map((k, v) => MapEntry<String, List<String>>(k, v == null ? [] : List<String>.from(v!.map((x) => x)))),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x).toList())),
        "status": status,
      };
}

class BreedImage {
  BreedImage({
    required this.message,
    required this.status,
  });

  final List<String> message;
  final String? status;

  BreedImage copyWith({
    List<String>? message,
    String? status,
  }) {
    return BreedImage(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  factory BreedImage.fromJson(Map<String, dynamic> json) {
    return BreedImage(
      message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x).toList(),
        "status": status,
      };
}

class SubBreedResponse {
  SubBreedResponse({
    required this.message,
    required this.status,
  });

  final List<String> message;
  final String? status;

  SubBreedResponse copyWith({
    List<String>? message,
    String? status,
  }) {
    return SubBreedResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  factory SubBreedResponse.fromJson(Map<String, dynamic> json) {
    return SubBreedResponse(
      message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message.map((x) => x).toList(),
        "status": status,
      };
}
