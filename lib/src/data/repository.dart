import 'dart:convert';

import 'package:amia_assignment/src/models/random_dog_image_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _randomDogImageEndpoint = "https://dog.ceo/api/breeds/image/random";

final randomDogImageProvider = FutureProvider<RandomDogImageResponse>((ref) async {
  final response = await http.get(Uri.parse(_randomDogImageEndpoint));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});
