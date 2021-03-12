import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/network/movie_db_client.dart';

class Movie extends Equatable {
  final int id;
  final String imbdId;
  String cardId;
  final String title;
  final String language;
  final String overview;
  final int popularity;
  final String posterPath;
  final DateTime releaseDate;

  Movie({
    this.id,
    this.imbdId,
    this.cardId,
    this.title,
    this.language,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
  });

  @override
  List<Object> get props => [
        id,
        imbdId,
        cardId,
        title,
        language,
        overview,
        popularity,
        posterPath,
        releaseDate,
      ];

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json == null) return Movie();

    return Movie(
      id: json['id'],
      imbdId: json['imdb_id'],
      cardId: null,
      title: json['original_title'],
      language: json['original_language'],
      overview: json['overview'],
      popularity: json['popularity'] is double
          ? _convertPopularityToInt(json['popularity'])
          : json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: DateTime.parse(json['release_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imdb_id': imbdId,
      'original_title': title,
      'original_language': language,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': DateFormat('d MMM yyyy').add_jm().format(releaseDate),
    };
  }

  static int _convertPopularityToInt(double value) => value.round();

  String getImagePath() {
    return '${MovieDbClient.images_host}/${this.posterPath}';
  }

  String getDateAsString() {
    return DateFormat('d MMM y, ').add_jm().format(this.releaseDate);
  }
}
