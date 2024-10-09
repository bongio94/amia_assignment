class Breeds {
    Breeds({
        required this.message,
        required this.status,
    });

    final Map<String, List<String>> message;
    final String? status;

    Breeds copyWith({
        Map<String, List<String>>? message,
        String? status,
    }) {
        return Breeds(
            message: message ?? this.message,
            status: status ?? this.status,
        );
    }

    factory Breeds.fromJson(Map<String, dynamic> json){ 
        return Breeds(
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

    factory BreedImage.fromJson(Map<String, dynamic> json){ 
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

