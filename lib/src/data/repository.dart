import 'dart:convert';

import 'package:amia_assignment/src/models/breeds_model.dart';
import 'package:amia_assignment/src/models/random_dog_image_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _randomDogImageEndpoint = "https://dog.ceo/api/breeds/image/random";
const _breedsListEndpoint = "https://dog.ceo/api/breeds/list/all";
const _breedPictureBaseEndpoint = "https://dog.ceo/api/breed/";

final randomDogImageProvider = FutureProvider<RandomDogImageResponse>((ref) async {
  final response = await http.get(Uri.parse(_randomDogImageEndpoint));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

final randomDogByBreedProvider = FutureProvider<Breeds>((ref) async {
  final response = await http.get(Uri.parse(_breedsListEndpoint));

  if (response.statusCode == 200) {
    return Breeds.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

final breedPictureProvider = FutureProvider.family<BreedImage, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedPictureBaseEndpoint$breed/images'));

  if (response.statusCode == 200) {
    return BreedImage.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});
