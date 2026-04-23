class Movie {
  final int id;
  final String name;
  final String imageUrl;
  final String summary;
  final double rating;
  final List<String> genres;

  Movie({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.summary,
    required this.rating,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Title',
      imageUrl: json['image'] != null ? (json['image']['medium'] ?? '') : '',
      summary: json['summary'] ?? 'No summary available',
      rating: json['rating'] != null && json['rating']['average'] != null
          ? (json['rating']['average'] as num).toDouble()
          : 0.0,
      genres: json['genres'] != null
          ? List<String>.from(json['genres'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'summary': summary,
      'rating': rating,
      'genres': genres,
    };
  }

  factory Movie.fromCache(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      summary: json['summary'],
      rating: (json['rating'] as num).toDouble(),
      genres: List<String>.from(json['genres']),
    );
  }
}