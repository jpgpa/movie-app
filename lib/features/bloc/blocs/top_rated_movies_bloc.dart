import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/bloc/list_state.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/bloc/events/top_rated_movies_event.dart';
import 'package:movie_app/features/domain/entities/movie_list.dart';
import 'package:movie_app/features/domain/usecases/get_top_rated_movies_usecase.dart';

const String _SERVER_FAILURE_MESSAGE = 'Server Failure';
const String _NETWORK_FAILURE_MESSAGE = 'Network Failure';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, ListState> {
  final GetTopRatedMoviesUsecase getTopRatedMovies;

  TopRatedMoviesBloc({
    @required GetTopRatedMoviesUsecase topRatedMovies,
  })  : assert(topRatedMovies != null),
        getTopRatedMovies = topRatedMovies,
        super(Init());

  @override
  Stream<ListState> mapEventToState(TopRatedMoviesEvent event) async* {
    if (event is GetTopRatedMovies) {
      yield Loading();
      final failureOrMovieList = await getTopRatedMovies(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrMovieList);
    }
  }

  Stream<ListState> _eitherLoadedOrErrorState(
      Either<Failure, MovieList> failureOrMovieList) async* {
    yield failureOrMovieList.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (movieList) => Loaded(list: movieList),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return _SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return _NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
