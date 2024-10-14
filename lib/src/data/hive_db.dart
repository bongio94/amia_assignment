import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provider for the FavsRepo
final favsRepoProvider = Provider<FavoritesRepository>((ref) => FavoritesRepository());

/// StateNotifierProvider for managing favorites
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Map<String, int>>((ref) {
  final favsRepo = ref.watch(favsRepoProvider);
  return FavoritesNotifier(favsRepo);
});

/// StateNotifier class for managing favorites
class FavoritesNotifier extends StateNotifier<Map<String, int>> {
  final FavoritesRepository _favsRepo;

  FavoritesNotifier(this._favsRepo) : super(_favsRepo.getUserFavorites());

  Future<void> addFavorite(String breed, int subBreedCount) async {
    await _favsRepo.addFavorite(breed, subBreedCount);
    state = _favsRepo.getUserFavorites();
  }

  Future<void> removeFavorite(String breed) async {
    await _favsRepo.removeFavorite(breed);
    state = _favsRepo.getUserFavorites();
  }

  bool isFavorite(String breed) {
    return state.containsKey(breed);
  }

  Future<void> clearAllFavorites() async {
    await _favsRepo.clearAllFavorites();
    state = {};
  }

  int getFavoritesCount() {
    return state.length;
  }

  Future<void> toggleFavorite(String breed, int subBreedCount) async {
    await _favsRepo.toggleFavorite(breed, subBreedCount);
    // Create a new map instance to ensure Riverpod detects the change
    state = Map<String, int>.from(_favsRepo.getUserFavorites());
  }

  int? getSubBreedCount(String breed) {
    return state[breed];
  }
}

/// Repository class for managing favorite dog breeds using Hive.
class FavoritesRepository {
  late Box<Map<String, int>> _favsBox;

  /// Constructor that initializes the Hive box.
  FavoritesRepository() {
    _favsBox = Hive.box<Map<String, int>>('favs');
  }

  /// Initializes the Hive box if it's not already open.
  Future<void> initBox() async {
    if (!Hive.isBoxOpen('favs')) {
      _favsBox = await Hive.openBox<Map<String, int>>('favs');
    }
  }

  /// Adds a breed to the user's favorites.
  ///
  /// [breed] The breed to be added.
  /// [subBreedCount] The sub-breed count for the breed.
  Future<void> addFavorite(String breed, int subBreedCount) async {
    Map<String, int> currentFavs = getUserFavorites();
    currentFavs[breed] = subBreedCount;
    await _favsBox.put('userFavs', currentFavs);
  }

  /// Removes a breed from the user's favorites.
  ///
  /// [breed] The breed to be removed.
  Future<void> removeFavorite(String breed) async {
    Map<String, int> currentFavs = getUserFavorites();
    currentFavs.remove(breed);
    await _favsBox.put('userFavs', currentFavs);
  }

  /// Retrieves the user's favorite breeds from the Hive box.
  ///
  /// Returns a Map of Strings containing the favorite breeds.
  /// If no favorites are found, returns an empty Map.
  Map<String, int> getUserFavorites() {
    return _favsBox.get('userFavs', defaultValue: {}) ?? {};
  }

  /// Checks if a breed is in the user's favorites.
  ///
  /// [breed] The breed to check.
  /// Returns true if the breed is a favorite, false otherwise.
  bool isFavorite(String breed) {
    return getUserFavorites().containsKey(breed);
  }

  /// Clears all favorites from the Hive box.
  Future<void> clearAllFavorites() async {
    await _favsBox.put('userFavs', {});
  }

  /// Gets the count of favorite breeds.
  ///
  /// Returns the number of favorite breeds.
  int getFavoritesCount() {
    return getUserFavorites().length;
  }

  /// Toggles the favorite status of a breed.
  ///
  /// [breed] The breed to toggle.
  /// [subBreedCount] The sub-breed count for the breed.
  /// If the breed is already a favorite, it will be removed.
  /// If it's not a favorite, it will be added.
  Future<void> toggleFavorite(String breed, int subBreedCount) async {
    Map<String, int> currentFavs = getUserFavorites();
    if (currentFavs.containsKey(breed)) {
      await removeFavorite(breed);
    } else {
      await addFavorite(breed, subBreedCount);
    }
  }

  int? getSubBreedCount(String breed) {
    return getUserFavorites()[breed];
  }
}
