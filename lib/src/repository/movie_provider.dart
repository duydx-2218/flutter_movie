import 'dart:convert';
import 'package:http/http.dart';
import 'package:the_movie/src/models/movie_item.dart';

class MovieProvider {
  Client client = Client();
  final apiKey = '807529ba16b21af4aea66dc79ec0be7b';

  Future<MovieItem> fetchMovieList(int page) async {
    final response = await client
        .get(Uri.parse('http://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=$page'));
    if (response.statusCode == 200) {
      return MovieItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Có lỗi xảy ra');
    }
  }
}
