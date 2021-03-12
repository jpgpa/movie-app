import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/bloc/object_state.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/bloc/events/movie_details_event.dart';
import 'package:movie_app/features/domain/entities/movie.dart';
import 'package:movie_app/features/domain/usecases/get_movie_details_usecase.dart';

const String _SERVER_FAILURE_MESSAGE = 'Server Failure';
const String _NETWORK_FAILURE_MESSAGE = 'Network Failure';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, ObjectState> {
  final GetMovieDetailsUsecase getMovieDetails;

  MovieDetailsBloc({
    @required GetMovieDetailsUsecase movieDetails,
  })  : assert(movieDetails != null),
        getMovieDetails = movieDetails,
        super(Init());

  @override
  Stream<ObjectState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is GetMovieDetails) {
      yield Loading();
      final failureOrMovieDetails =
          await getMovieDetails(GetMovieDetailsParams(movieId: event.movieId));
      yield* _eitherLoadedOrErrorState(failureOrMovieDetails);
    }
  }

  Stream<ObjectState> _eitherLoadedOrErrorState(
      Either<Failure, Movie> failureOrMovieDetails) async* {
    yield failureOrMovieDetails.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (movie) => Loaded(object: movie),
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
