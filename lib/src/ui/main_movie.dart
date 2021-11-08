import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/src/bloc/movies_bloc.dart';
import 'package:the_movie/src/models/movie.dart';
import 'package:the_movie/src/models/movie_item.dart';
import 'package:the_movie/src/ui/movie_detail.dart';

class MainMovie extends StatefulWidget {
  const MainMovie({Key? key}) : super(key: key);

  @override
  _MainMovieState createState() => _MainMovieState();
}

class _MainMovieState extends State<MainMovie> {
  final moviesBloc = MoviesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie')),
      body: StreamBuilder(
        stream: moviesBloc.allMovies,
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(child: NotificationListener<ScrollEndNotification>(
                child: moviesListView(snapshot),
                onNotification: (ScrollEndNotification scroll) {
                  if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                    moviesBloc.fetchMovies();
                  }
                  return true;
                }), onRefresh: () { return moviesBloc.refreshMovies();});
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget moviesListView(AsyncSnapshot<List<Movie>> snapshot) {
    if (snapshot.data == null) {
      return const Text("Không có dữ liệu");
    }
    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetail(
                      movie: snapshot.data![index],
                    )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CachedNetworkImage(
                      imageUrl:
                      'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath ?? ""}',
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 32.0,
                          width: 32.0,
                        ),
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      width: 100,
                      height: 150),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index].title,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(snapshot.data![index].overview, maxLines: 5)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
