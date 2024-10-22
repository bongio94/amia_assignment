import 'dart:convert';

import 'package:amia_assignment/src/models/breeds_model.dart';
import 'package:amia_assignment/src/models/random_dog_image_model.dart';
import 'package:amia_assignment/src/presentation/widgets/dog_details/breed_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _baseUrl = "https://dog.ceo/api/";
const _breedEndpoint = "${_baseUrl}breed/";
const _breedsListEndpoint = "${_baseUrl}breeds/list/all";

/// Fetches a random dog image for a given breed.
///
/// This provider takes a [String] parameter representing the breed and returns
/// a [FutureProvider] that resolves to a [RandomDogImageResponse].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final randomDogImageProvider = FutureProvider.family<RandomDogImageResponse, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedEndpoint${breed.toLowerCase()}/images/random'));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

/// Fetches a random dog image for a given sub-breed.
///
/// This provider takes a [List<String>] parameter where the first element is the breed
/// and the second element is the sub-breed. It returns a [FutureProvider] that
/// resolves to a [RandomDogImageResponse].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final randomDogBySubBreedImageProvider = FutureProvider.family<RandomDogImageResponse, List<String>>((ref, subBreed) async {
  final response = await http.get(Uri.parse('$_breedEndpoint${subBreed.first.toLowerCase()}/${subBreed.last.toLowerCase()}/images/random'));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

/// Fetches a list of all dog breeds.
///
/// This provider returns a [FutureProvider] that resolves to a [BreedsResponse].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final randomDogByBreedProvider = FutureProvider<BreedsResponse>((ref) async {
  final response = await http.get(Uri.parse(_breedsListEndpoint));

  if (response.statusCode == 200) {
    return BreedsResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

/// Fetches images for a specific dog breed.
///
/// This provider takes a [String] parameter representing the breed and returns
/// a [FutureProvider] that resolves to a [BreedImage].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final breedPictureProvider = FutureProvider.family<BreedImage, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedEndpoint$breed/images'));

  if (response.statusCode == 200) {
    return BreedImage.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch random dog image');
});

/// Fetches a list of sub-breeds for a specific dog breed.
///
/// This provider takes a [String] parameter representing the breed and returns
/// a [FutureProvider] that resolves to a [SubBreedResponse].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final subBreedProvider = FutureProvider.family<SubBreedResponse, String>((ref, breed) async {
  final response = await http.get(Uri.parse('$_breedEndpoint${breed.toLowerCase()}/list'));

  if (response.statusCode == 200) {
    return SubBreedResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch breed list');
});

/// Fetches a random image for a specific sub-breed.
///
/// This provider takes a [String] parameter representing the sub-breed and returns
/// a [FutureProvider] that resolves to a [RandomDogImageResponse].
///
/// It uses the [currentBreedProvider] to get the current breed selected in the [BreedDetailsView].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final subBreedRandomImageProvider = FutureProvider.autoDispose.family<RandomDogImageResponse, String>((ref, breed) async {
  final currentBreed = ref.watch(currentBreedProvider);

  final response = await http.get(Uri.parse('$_breedEndpoint${currentBreed.toLowerCase()}/${breed.toLowerCase()}/images/random'));

  if (response.statusCode == 200) {
    return RandomDogImageResponse.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch breed list');
});

/// Fetches all images for a specific sub-breed.
///
/// This provider takes a [String] parameter representing the sub-breed and returns
/// a [FutureProvider] that resolves to a [BreedImage].
///
/// It uses the [currentBreedProvider] to get the current breed selected in the [BreedDetailsView].
///
/// If the API call is successful, it returns the parsed response.
/// If the API call fails, it throws an exception.
final subBreedImagesProvider = FutureProvider.autoDispose.family<BreedImage, String>((ref, breed) async {
  final currentBreed = ref.watch(currentBreedProvider);

  final response = await http.get(Uri.parse('$_breedEndpoint${currentBreed.toLowerCase()}/${breed.toLowerCase()}/images'));

  if (response.statusCode == 200) {
    return BreedImage.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to fetch breed list');
});
