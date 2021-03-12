import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/features/bloc/blocs/movie_details_bloc.dart';
import 'package:movie_app/features/bloc/blocs/popular_movies_bloc.dart';
import 'package:movie_app/features/bloc/blocs/top_rated_movies_bloc.dart';
import 'package:movie_app/features/data/datasources/movies_remote_datasource.dart';
import 'package:movie_app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/features/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/domain/usecases/get_popular_movies_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/domain/usecases/get_top_rated_movies_usecase.dart';

final singleton = GetIt.instance;

Future<void> init() async {
  //Blocs
  singleton.registerFactory(
    () => PopularMoviesBloc(popularMovies: singleton()),
  );
  singleton.registerFactory(
    () => MovieDetailsBloc(movieDetails: singleton()),
  );
  singleton.registerFactory(
    () => TopRatedMoviesBloc(topRatedMovies: singleton()),
  );

  //Usecases
  singleton.registerLazySingleton(() => GetPopularMoviesUsecase(singleton()));
  singleton.registerLazySingleton(() => GetTopRatedMoviesUsecase(singleton()));
  singleton.registerLazySingleton(() => GetMovieDetailsUsecase(singleton()));

  //Repositories
  singleton.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImplementation(
      moviesRemoteDatasource: singleton(),
      networkInfo: singleton(),
    ),
  );

  //Datasources
  singleton.registerLazySingleton<MoviesRemoteDatasource>(
    () => MoviesRemoteDatasourceImplementation(
      client: singleton(),
    ),
  );

  //Core
  singleton.registerLazySingleton(() => NetworkInfoImplementation(singleton()));

  //External
  singleton.registerLazySingleton(() => http.Client());
  singleton.registerLazySingleton(() => DataConnectionChecker());
}
