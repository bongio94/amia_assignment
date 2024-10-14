import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provider for the FavsRepo
final favsRepoProvider = Provider<FavoritesRepository>((ref) => FavoritesRepository());

/// StateNotifierProvider for managing favorites
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final favsRepo = ref.watch(favsRepoProvider);
  return FavoritesNotifier(favsRepo);
});

/// StateNotifier class for managing favorites
class FavoritesNotifier extends StateNotifier<Set<String>> {
  final FavoritesRepository _favsRepo;

  FavoritesNotifier(this._favsRepo) : super(_favsRepo.getUserFavorites());

  Future<void> addFavorite(String breed) async {
    await _favsRepo.addFavorite(breed);
    state = _favsRepo.getUserFavorites();
  }

  Future<void> removeFavorite(String breed) async {
    await _favsRepo.removeFavorite(breed);
    state = _favsRepo.getUserFavorites();
  }

  bool isFavorite(String breed) {
    return state.contains(breed);
  }

  Future<void> clearAllFavorites() async {
    await _favsRepo.clearAllFavorites();
    state = {};
  }

  int getFavoritesCount() {
    return state.length;
  }

  Future<void> toggleFavorite(String breed) async {
    await _favsRepo.toggleFavorite(breed);
    state = _favsRepo.getUserFavorites();
  }
}

/// Repository class for managing favorite dog breeds using Hive.
class FavoritesRepository {
  /// The Hive box used to store favorite breeds.
  late Box<List<String>> _favsBox;

  /// Constructor that initializes the Hive box.
  FavoritesRepository() {
    _favsBox = Hive.box<List<String>>('favs');
  }

  /// Initializes the Hive box if it's not already open.
  Future<void> initBox() async {
    if (!Hive.isBoxOpen('favs')) {
      _favsBox = await Hive.openBox<List<String>>('favs');
    }
  }

  /// Adds a breed to the user's favorites.
  ///
  /// [breed] The breed to be added.
  Future<void> addFavorite(String breed) async {
    Set<String> currentFavs = getUserFavorites();
    currentFavs.add(breed);
    await _favsBox.put('userFavs', currentFavs.toList());
  }

  /// Removes a breed from the user's favorites.
  ///
  /// [breed] The breed to be removed.
  Future<void> removeFavorite(String breed) async {
    Set<String> currentFavs = getUserFavorites();
    currentFavs.remove(breed);
    await _favsBox.put('userFavs', currentFavs.toList());
  }

  /// Retrieves the user's favorite breeds from the Hive box.
  ///
  /// Returns a Set of Strings containing the favorite breeds.
  /// If no favorites are found, returns an empty Set.
  Set<String> getUserFavorites() {
    List<String> favsList = _favsBox.get('userFavs', defaultValue: []) ?? [];
    return favsList.toSet();
  }

  /// Checks if a breed is in the user's favorites.
  ///
  /// [breed] The breed to check.
  /// Returns true if the breed is a favorite, false otherwise.
  bool isFavorite(String breed) {
    return getUserFavorites().contains(breed);
  }

  /// Clears all favorites from the Hive box.
  Future<void> clearAllFavorites() async {
    await _favsBox.put('userFavs', []);
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
  /// If the breed is already a favorite, it will be removed.
  /// If it's not a favorite, it will be added.
  Future<void> toggleFavorite(String breed) async {
    Set<String> currentFavs = getUserFavorites();
    if (currentFavs.contains(breed)) {
      await removeFavorite(breed);
    } else {
      await addFavorite(breed);
    }
  }
}