import 'package:the_movie/src/models/movie.dart';

class MovieItem {
  int page = 0;
  int totalResults = 0;
  int totalPages = 0;
  List<Movie> movies = [];

  MovieItem.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    totalResults = parsedJson['total_results'];
    totalPages = parsedJson['total_pages'];
    movies = List<Movie>.from(parsedJson['results']?.map((x) => Movie.fromMap(x)));
  }
}
