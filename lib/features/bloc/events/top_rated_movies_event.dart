import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable {
  TopRatedMoviesEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class GetTopRatedMovies extends TopRatedMoviesEvent {}
