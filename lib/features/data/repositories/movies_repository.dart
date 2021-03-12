import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/features/data/datasources/movies_remote_datasource.dart';
import 'package:movie_app/features/domain/entities/movie.dart';
import 'package:movie_app/features/domain/entities/movie_list.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MovieList>> getPopularMovies();
  Future<Either<Failure, MovieList>> getTopRatedMovies();
  Future<Either<Failure, Movie>> getMovieDetails(int movieId);
}

class MoviesRepositoryImplementation implements MoviesRepository {
  final MoviesRemoteDatasource moviesRemoteDatasource;
  final NetworkInfoImplementation networkInfo;

  MoviesRepositoryImplementation(
      {@required this.moviesRemoteDatasource, @required this.networkInfo});

  @override
  Future<Either<Failure, MovieList>> getPopularMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final popularMovies = await moviesRemoteDatasource.getPopularMovies();
        return Right(popularMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final movieDetails =
            await moviesRemoteDatasource.getMovieDetails(movieId);
        return Right(movieDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, MovieList>> getTopRatedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final topRatedMovies = await moviesRemoteDatasource.getTopRatedMovies();
        return Right(topRatedMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
