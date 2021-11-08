import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:the_movie/src/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie detail"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                ClipPath(
                    clipper: ClipPathClass(),
                    child: SizedBox(child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${movie.backdropPath ?? ""}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 32.0,
                          width: 32.0,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))),
                Positioned(
                  bottom: 0,
                  left: 16,
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${movie.posterPath ?? ""}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                              height: 32.0,
                              width: 32.0,
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 100,
                      height: 150),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(movie.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  CircularPercentIndicator(
                    radius: 32.0,
                    lineWidth: 4.0,
                    animation: true,
                    percent: movie.voteAverage / 10,
                    center: Text(
                      movie.voteAverage.toString(),
                      style: const TextStyle(fontSize: 10.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.black,
                  ),
                ],
              )),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Icon(
                      Icons.announcement_rounded,
                      color: Colors.green,
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                width: 0.5,
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Icon(
                      Icons.offline_bolt_sharp,
                      color: Colors.red,
                    ),
                    Text(
                      "Trailers",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Text(
                      "Genre",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Drama",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Release Date",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      movie.releaseDate,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Padding(
              padding: const EdgeInsets.all(16), child: Text(movie.overview))
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 3 / 4);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
