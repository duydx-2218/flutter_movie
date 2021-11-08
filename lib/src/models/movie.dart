class Movie {
  String? posterPath;
  bool adult = false;
  String overview = "";
  String releaseDate = "";
  List<int> genreIds = [];
  int id = 0;
  String originalTitle = "";
  String originalLanguage = "";
  String title = "";
  String? backdropPath;
  var popularity = 0.0;
  int voteCount = 0;
  bool video = false;
  var voteAverage = 0.0;

  Movie({
    this.posterPath = "",
    this.adult = false,
    this.overview = "",
    this.releaseDate = "",
    this.genreIds = const [],
    this.id = 0,
    this.originalTitle = "",
    this.originalLanguage = "",
    this.title = "",
    this.backdropPath = "",
    this.popularity = 0.0,
    this.voteCount = 0,
    this.video = false,
    this.voteAverage = 0.0,
  });

  factory Movie.fromMap(Map<String, dynamic> movie) {
    return Movie(
        posterPath: movie['poster_path'],
        adult: movie['adult'],
        overview: movie['overview'],
        releaseDate: movie['release_date'],
        genreIds: List<int>.from(movie['genre_ids']?.map((x) => x)),
        id: movie['id'],
        originalTitle: movie['original_title'],
        originalLanguage: movie['original_language'],
        title: movie['title'],
        backdropPath: movie['backdrop_path'],
        popularity: double.parse(movie['popularity'].toString()),
        voteCount: movie['vote_count'],
        video: movie['video'],
        voteAverage: double.parse(movie['vote_average'].toString()));
  }
}
