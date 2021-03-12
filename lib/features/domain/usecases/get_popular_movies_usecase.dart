import 'package:movie_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/features/domain/entities/movie_list.dart';

class GetPopularMoviesUsecase extends UseCase<MovieList, NoParams> {
  final MoviesRepository moviesRepository;

  GetPopularMoviesUsecase(this.moviesRepository);

  @override
  Future<Either<Failure, MovieList>> call(NoParams params) async {
    return await moviesRepository.getPopularMovies();
  }
}
