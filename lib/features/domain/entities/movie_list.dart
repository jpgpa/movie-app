import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:movie_app/features/domain/entities/movie.dart';

class MovieList extends Equatable {
  final List<Movie> movies;

  MovieList({@required this.movies});

  @override
  List<Object> get props => movies;

  factory MovieList.fromJson(Map<String, dynamic> parsedJson) {
    List<Movie> movies = <Movie>[];
    var jsonAsList = parsedJson['results'] as List<dynamic>;
    movies = jsonAsList.map((i) => Movie.fromJson(i)).toList();

    return new MovieList(
      movies: movies,
    );
  }

  List<Map<String, dynamic>> toJson() {
    var sectionListJson = List<Map<String, dynamic>>();
    for (Movie movie in movies) {
      var sectionJson = movie.toJson();
      sectionListJson.add(sectionJson);
    }

    return sectionListJson;
  }
}
