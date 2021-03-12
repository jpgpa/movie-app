import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/features/domain/entities/movie.dart';

class GetMovieDetailsUsecase extends UseCase<Movie, GetMovieDetailsParams> {
  final MoviesRepository moviesRepository;

  GetMovieDetailsUsecase(this.moviesRepository);

  @override
  Future<Either<Failure, Movie>> call(GetMovieDetailsParams params) async {
    final movieId = params.movieId;
    return await moviesRepository.getMovieDetails(movieId);
  }
}

class GetMovieDetailsParams extends Equatable {
  final int movieId;

  GetMovieDetailsParams({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}
