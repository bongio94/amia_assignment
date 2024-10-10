import 'dart:convert';

import 'package:amia_assignment/src/models/breeds_model.dart';
import 'package:amia_assignment/src/models/random_dog_image_model.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/breed_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _randomDogImageEndpoint = "https://dog.ceo/api/breeds/image/random";
const _breedsListEndpoint = "https://dog.ceo/api/breeds/list/all";
const _breedBaseEndpoint = "https://dog.ceo/api/breed/";

final randomDogImageProvider = FutureProvider<RandomDogImageResponse>((ref) async {
  final response = await http.get(Uri.parse(_randomDogImageEndpoint));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

final randomDogByBreedProvider = FutureProvider<BreedsResponse>((ref) async {
  final response = await http.get(Uri.parse(_breedsListEndpoint));

  if (response.statusCode == 200) {
    return BreedsResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

final breedPictureProvider = FutureProvider.family<BreedImage, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedBaseEndpoint$breed/images'));

  if (response.statusCode == 200) {
    return BreedImage.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

final subBreedProvider = FutureProvider.family<SubBreedResponse, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedBaseEndpoint${breed.toLowerCase()}/list'));

  if (response.statusCode == 200) {
    return SubBreedResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch breed list');
});

final subBreedRandomImageProvider = FutureProvider.autoDispose.family<RandomDogImageResponse, String>((ref, breed) async {
  final currentBreed = ref.watch(currentBreedProvider);

  final response = await http.get(Uri.parse('$_breedBaseEndpoint${currentBreed.toLowerCase()}/${breed.toLowerCase()}/images/random'));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch breed list');
});
