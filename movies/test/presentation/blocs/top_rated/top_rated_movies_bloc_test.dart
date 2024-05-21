import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMoviesList = <Movie>[testMovie];

  test('init state should be empty', () {
    expect(
      topRatedMoviesBloc.state,
      TopRatedMoviesEmpty(),
    );
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Emit Loading has Data when data is success',
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => Right(tMoviesList),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchTopRatedMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(tMoviesList),
    ],
    verify: (bloc) => verify(
      mockGetTopRatedMovies.execute(),
    ),
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Emit Loading Error when get top rated movies is failed',
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchTopRatedMovies(),
    ),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(
      mockGetTopRatedMovies.execute(),
    ),
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Emit Loading Empty when data is empty',
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => const Right([]),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(
      FetchTopRatedMovies(),
    ),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesEmpty(),
    ],
    verify: (bloc) => verify(
      mockGetTopRatedMovies.execute(),
    ),
  );
}
