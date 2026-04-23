import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class CacheService {
  static const String cacheKey = 'cached_movies';

  Future<void> saveMovies(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(movies.map((movie) => movie.toJson()).toList());
    await prefs.setString(cacheKey, encoded);
  }

  Future<List<Movie>> getCachedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData == null) return [];

    final List decoded = jsonDecode(cachedData);
    return decoded.map((item) => Movie.fromCache(item)).toList();
  }
}