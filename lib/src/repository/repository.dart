import 'package:the_movie/src/models/movie_item.dart';
import 'package:the_movie/src/repository/movie_provider.dart';

class Repository {
  final moviesProvider = MovieProvider();

  Future<MovieItem> fetchMovies(int page) => moviesProvider.fetchMovieList(page);
}
