import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMoviesList = <Movie>[testMovie];

  test('init state should be empty', () {
    expect(
      popularMoviesBloc.state,
      PopularMoviesEmpty(),
    );
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Emit Loading has Data when data is success',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer(
        (_) async => Right(tMoviesList),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchPopularMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(tMoviesList),
    ],
    verify: (bloc) => verify(
      mockGetPopularMovies.execute(),
    ),
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Emit Loading Error when get popular movies is failed',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchPopularMovies(),
    ),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetPopularMovies.execute(),
    ),
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Emit Loading Empty when data is empty',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer(
        (_) async => const Right([]),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchPopularMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
    verify: (bloc) => verify(
      mockGetPopularMovies.execute(),
    ),
  );
}
