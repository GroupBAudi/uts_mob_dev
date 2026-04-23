import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();

  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];

  bool _isLoading = false;
  bool _isOffline = false;
  String _errorMessage = '';
  String _selectedGenre = 'All';

  List<Movie> get movies => _filteredMovies;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;
  String get errorMessage => _errorMessage;
  String get selectedGenre => _selectedGenre;

  Future<void> fetchMovies() async {
    _isLoading = true;
    _errorMessage = '';
    _isOffline = false;
    notifyListeners();

    try {
      final result = await _apiService.fetchMovies();
      _movies = result;
      _filteredMovies = result;
      await _cacheService.saveMovies(result);
    } catch (e) {
      final cachedMovies = await _cacheService.getCachedMovies();
      if (cachedMovies.isNotEmpty) {
        _movies = cachedMovies;
        _filteredMovies = cachedMovies;
        _isOffline = true;
        _errorMessage = 'Internet sedang bermasalah. Menampilkan data terakhir.';
      } else {
        _errorMessage = 'Ups, data belum bisa dimuat. Coba lagi sebentar lagi.';
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    List<Movie> results = _movies.where((movie) {
      return movie.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (_selectedGenre != 'All') {
      results = results
          .where((movie) => movie.genres.contains(_selectedGenre))
          .toList();
    }

    _filteredMovies = results;
    notifyListeners();
  }

  void filterByGenre(String genre) {
    _selectedGenre = genre;

    if (genre == 'All') {
      _filteredMovies = _movies;
    } else {
      _filteredMovies =
          _movies.where((movie) => movie.genres.contains(genre)).toList();
    }

    notifyListeners();
  }

  List<String> getGenres() {
    final genres = <String>{'All'};
    for (final movie in _movies) {
      genres.addAll(movie.genres);
    }
    return genres.toList();
  }
}