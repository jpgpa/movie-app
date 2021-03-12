import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  MovieDetailsEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class GetMovieDetails extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetails(this.movieId);

  @override
  List<Object> get props => [movieId];
}
