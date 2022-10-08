import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants.dart';
import 'package:movie_app/modalmovielist.dart';
import 'package:movie_app/moviedetails.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  bool proccessing = false;
  List<Results>? movielist = [];
  TextEditingController searchquery = TextEditingController();

  void getSearchMovies() async {
    setState(() {
      proccessing = true;
    });
    String url1 =
        "https://api.themoviedb.org/3/search/movie?api_key=${MoviesContstans.apikey}&query=${searchquery.text}";
    Uri url = Uri.parse(url1);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      movielist!.clear();
      movielist = MoviesModal.fromJson(jsonDecode(response.body)).results;
      print("listfetched");
      setState(() {});
    } else {}
    setState(() {
      proccessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Watch",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: TextField(
                  autofocus: true,
                  controller: searchquery,
                  decoration: InputDecoration(
                    hintText: "Please Enter Movie Name",
                    suffixIcon: IconButton(
                        onPressed: () {
                          getSearchMovies();
                          // FocusManager.instance.primaryFocus?.unfocus();
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: proccessing
            ? CircularProgressIndicator()
            : movielist!.isEmpty
                ? Center(
                    child: Text("Not Data found"),
                  )
                : ListView.builder(
                    itemCount: movielist!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          log("${movielist![index].posterPath}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetails(movie: movielist![index]),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Hero(
                                      tag:
                                          "https://image.tmdb.org/t/p/original${movielist![index].posterPath}",
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/original${movielist![index].posterPath}",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${movielist![index].originalTitle}",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }
}
