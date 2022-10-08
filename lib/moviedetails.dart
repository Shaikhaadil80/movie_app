import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:movie_app/modalmovielist.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie});
  final Results movie;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height * 0.60,
                child: Hero(
                  tag:
                      "https://image.tmdb.org/t/p/original${widget.movie.posterPath}",
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://image.tmdb.org/t/p/original${widget.movie.posterPath}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height * 0.40,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Overview",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SingleChildScrollView(
                          child: Text(
                            "${widget.movie.overview}",
                            style:
                                TextStyle(color: Colors.grey, letterSpacing: 1
                                    // fontSize: 18
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Text(
                        widget.movie.originalTitle.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
