import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PopularMoviesEvent extends Equatable {
  PopularMoviesEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class GetPopularMovies extends PopularMoviesEvent {}
