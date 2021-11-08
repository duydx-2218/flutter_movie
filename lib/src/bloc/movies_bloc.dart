import 'package:rxdart/subjects.dart';
import 'package:the_movie/src/models/movie.dart';
import 'package:the_movie/src/models/movie_item.dart';
import 'package:the_movie/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final repository = Repository();

  final moviesPublisher = PublishSubject<List<Movie>>();
  var page = 0;
  var totalPage = 0;
  var movies = <Movie>[];

  Stream<List<Movie>> get allMovies => moviesPublisher.stream;

  refreshMovies() async {
    page = 0;
    totalPage = 0;
    movies = [];
    fetchMovies();
  }

  fetchMovies() async {
    if (page <= totalPage) {
      page += 1;
      MovieItem movieItem = await repository.fetchMovies(page);
      movies.addAll(movieItem.movies);
      moviesPublisher.sink.add(movies);
      totalPage = movieItem.totalPages;
    }
  }

  dispose() {
    moviesPublisher.close();
  }
}
